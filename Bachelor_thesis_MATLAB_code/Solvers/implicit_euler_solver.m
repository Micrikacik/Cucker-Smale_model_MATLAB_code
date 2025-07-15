function [Pos,C_Pos,P_Center,Vel,C_Vel,V_Center] = implicit_euler_solver(iter, dt, K, sigma, beta, init_pos, init_vel)

arguments
    iter;
    dt;
    K;
    sigma;
    beta;
    init_pos;
    init_vel;
end

% Simulates the implicit Euler model and calculates additional properties.
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
%   init_pos - Initial position matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a position of the i-th individuals), 
%   the second dimension can have any size.
%
%   init_vel - Initial position matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a velocity of the i-th individuals), 
%   the second dimension can have any size.
%
% Output:
%
%   Pos - Tensor containing positions of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep, including t = 0
%   and t = iter * dt (size of third dimension is iter + 1)
%
%   C_Pos - Tensor containing relative positions with respect to the center 
%   of the group of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep, including t = 0
%   and t = iter * dt (size of third dimension is iter + 1)
%
%   P_Center - Tensor containing positions of the center of the group 
%   of the whole simulation as "vectors stacked
%   behind eachother", i.e., first dimension has size 1, second
%   dimension is coordinate and third dimension is timestep, including t = 0
%   and t = iter * dt (size of third dimension is iter + 1)
%
%   Vel - Tensor containing velocities of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep, including t = 0
%   and t = iter * dt (size of third dimension is iter + 1)
%
%   C_Vel - Tensor containing relative velocity deviations with respect to their 
%   arithmetic mean of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep, including t = 0
%   and t = iter * dt (size of third dimension is iter + 1)
%
%   V_Center - Tensor containing arithmetic means of the velocities of the whole 
%   simulation as "vectors stacked behind eachother", i.e., first dimension 
%   is 1, second dimension is coordinate and third dimension is timestep, 
%   including t = 0 and t = iter * dt (size of third dimension is iter + 1)

X = init_pos;
V = init_vel;

[Pos, Vel] = implicit_euler(iter,dt,K,sigma,beta,X,V);

[C_Pos, C_Vel, P_Center, V_Center] = calculate_centers(Pos, Vel);