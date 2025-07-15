function [Pos, Vel] = implicit_euler(iter, dt, K, sigma, beta, X, V)

% Simulates the explicit Euler model.
%
% Arguments:
%
%   iter - Number of iterations.
%
%   dt - Timestep of the simulation.
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
%   dimension is coordinate and third dimension is timestep, including t =
%   0 and t = iter * dt (size of third dimension is iter + 1)
%
%   Vel - Tensor containing velocities of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep, including t =
%   0 and t = iter * dt (size of third dimension is iter + 1)


sizes = size(X);
Pos = zeros(sizes(1),sizes(2),iter+1);
Vel = zeros(sizes(1),sizes(2),iter+1);

Pos(:,:,1) = X;
Vel(:,:,1) = V;

for iteration = 1:iter
    % here we solve the implicit euler equation
    XV = fsolve(@(XV) euler_fun(XV, X, V, K, sigma, beta, dt), [X, V]);
    half = size(XV,2) / 2;
    X = XV(:,1:half);
    V = XV(:,(half+1):end);
    
    Pos(:,:,iteration+1) = X;
    Vel(:,:,iteration+1) = V;
end

function result = euler_fun(XV, X_before, V_before, K, sigma, beta, dt)
    half = size(XV,2) / 2;
    X = XV(:,1:half);
    V = XV(:,(half+1):end);
    L_x = create_matrices(X_before,K,sigma,beta);
    result = [X_before + dt * V - X, V_before - dt * L_x * V - V];
