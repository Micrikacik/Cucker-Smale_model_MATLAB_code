function [Pos, Vel] = simulate_discrete(iter, dt, K, sigma, beta, X, V)

% Simulates the discrete model (implicit Euler)
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
    L_x = create_matrices(X,K,sigma,beta);

    X = X + dt*V;
    V = V - dt*L_x*V;
    
    Pos(:,:,iteration+1) = X;
    Vel(:,:,iteration+1) = V;
end
