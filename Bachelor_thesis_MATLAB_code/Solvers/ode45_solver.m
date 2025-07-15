function [Pos,C_Pos,P_Center,Vel,C_Vel,V_Center,timesteps] = ode45_solver(time, K, sigma, beta, X, V)

arguments
    time;
    K;
    sigma;
    beta;
    X;
    V;
end

% Approximates the solution of the continuous model using ode45 solver
%
% Arguments:
%
%   time - Maximal time - solves the equations on the inteval [0,time].
%
%   K - Parameter of the model.
%
%   sigma - Parameter of the model.
%
%   beta - Parameter of the model.
%
%   X - Initial position matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a position of the i-th individuals), 
%   the second dimension can have any size.
%
%   V - Initial position matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a velocity of the i-th individuals), 
%   the second dimension can have any size.
%
% Output:
%
%   Pos - Tensor containing positions of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep in which were
%   the solution aproximated.
%
%   C_Pos - Tensor containing relative positions with respect to the center 
%   of the group of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep in which were
%   the solution aproximated.
%
%   P_Center - Tensor containing positions of the center of the group 
%   of the whole simulation as "vectors stacked
%   behind eachother", i.e., first dimension has size 1, second
%   dimension is coordinate and third dimension is timestep in which were
%   the solution aproximated.
%
%   Vel - Tensor containing velocities of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep in which were
%   the solution aproximated.
%
%   C_Vel - Tensor containing relative velocity deviations with respect to their 
%   arithmetic mean of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep in which were
%   the solution aproximated.
%
%   V_Center - Tensor containing arithmetic means of the velocities of the whole 
%   simulation as "vectors stacked behind eachother", i.e., first dimension 
%   is 1, second dimension is coordinate and third dimension is timestep in which were
%   the solution aproximated.
%
%   timesteps - Time point in which was the solution approximated 
%   (this is returned by the ode45 function)

count = size(X,1);
dim = size(X,2);
dim_count = dim*count;

Yx = reshape(X.',dim_count,1); % we have to transpose, so in the vector we have triplets of coordinates to each entity
Yv = reshape(V.',dim_count,1);

Y0 = [Yx; Yv];

% options = odeset('AbsTol',1e-14,'RelTol',1e-14); % high accuracy for order approximation
[t,y] = ode45(@(t,y) odefun(t,y,dim,count,K,sigma,beta),[0,time],Y0);

timesteps = t;
iter_count = length(timesteps);

Xm = y(:,1:dim_count);
Vm = y(:,(dim_count+1):end);

Pos = zeros(count,dim,iter_count);
Vel = zeros(count,dim,iter_count);

for i = 1:iter_count
    X_i = reshape(Xm(i,:).',dim,count).';   % first .' - its a row, not a column
                                            % reshape - we have column of vectors (positions/velocities)
                                            % second .' - coordinates must be in second dimension
    V_i = reshape(Vm(i,:).',dim,count).';
    Pos(:,:,i) = X_i;
    Vel(:,:,i) = V_i;
end

[C_Pos, C_Vel, P_Center, V_Center] = calculate_centers(Pos, Vel);

function dXdV = odefun(~, y, dim, count, K, sigma, beta)
    dim_count = dim*count;

    x = y(1:dim_count);
    
    X = reshape(x,dim,count).'; % in x we have triplets of coordinates after each other
    Lk_x = create_matrices(X,K,sigma,beta);

    I = eye(dim);

    L_x = kron(Lk_x,I);

    dX = y((dim_count+1):end);
    dV = -L_x*y((dim_count+1):end);

    dXdV = [dX; dV];
