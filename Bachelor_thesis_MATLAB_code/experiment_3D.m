function [] = experiment_3D(count, iter, dt, K, sigma, beta, init_pos, init_vel, show_center, simulate_implicit, colors)
  
arguments
    count = 3;
    iter = 50;
    dt = 0.2;
    K = 0.5;
    sigma = 3;
    beta = 0.1;
    init_pos = [];
    init_vel = [];
    show_center = true;
    simulate_implicit = true;
    colors = [];
end

% Simulates all models (implicit Euler, continuous, explicit Euler) 
% and plots figures for all of them plus a figure comparing them.
%
%   count - Count of individuals, used when no initial velocities or
%   positions are set.
%
%   iter - Number of simulation iterations for discrete models (iter * dt
%   will be maximal time for the continuous model).
%
%   dt - Timestep of simulation for discrete models (iter * dt will be
%   maximal time for the continuous model).
%
%   K - Parameter of the model.
%
%   sigma - Parameter of the model.
%
%   beta - Parameter of the model.
%
%   init_pos - Initial positions, it's a matrix with "count" rows and 3
%   columns (set to "[]" to skip this argument).
%
%   init_vel - Initial velocities, it's a matrix with "count" rows and 3
%   columns (set to "[]" to skip this argument).
%
%   show_center - Decides wether to show the arithmetic mean of positions
%   and velocities in their respective figures.
%
%   simulate_implicit - If set to "true", this function will simulate
%   implicit Euler model (this is the slower part of the program).
%
%   colors - Colors for individuals when plotting the graph, it's a matrix
%   with "count" rows and 3 columns (rgb triplet for each individual).

dim = 3;

X = init_pos;
V = init_vel;

if size(X,2) ~= dim || size(X,1) ~= count
    X = (rand(count, dim)-0.5)*2;
end

if size(V,2) ~= dim || size(V,1) ~= count
    V = (rand(count, dim)-0.5)*2;
end

[Pos, C_Pos_1, P_Center, Vel, C_Vel_1, V_Center] = experiment(iter, dt, K, sigma, beta, X, V);

a = figure("Name","Discrete simulation - Euler explicit");
figure(a);
result_plot_3D(Pos, Vel, P_Center, C_Pos_1, V_Center, C_Vel_1, show_center, colors);

[Pos, C_Pos_2, P_Center, Vel, C_Vel_2, V_Center] = ode45_solver(iter*dt, K, sigma, beta, X, V);

b = figure("Name","Numerical (ode45) solution");
figure(b);
result_plot_3D(Pos, Vel, P_Center, C_Pos_2, V_Center, C_Vel_2, show_center, colors);

if simulate_implicit

    [Pos, C_Pos_3, P_Center, Vel, C_Vel_3, V_Center] = implicit_euler_solver(iter, dt, K, sigma, beta, X, V);
    
    c = figure("Name","Discrete simulation - Euler implicit");
    figure(c);
    result_plot_3D(Pos, Vel, P_Center, C_Pos_3, V_Center, C_Vel_3, show_center, colors);
    
    d = figure("Name","Solution comparation");
    figure(d);
    comparison_plot_3D(C_Pos_2,C_Vel_2,"Numerical (ode45) solution",[0,1,0],...
        C_Pos_1,C_Vel_1,"Discrete simulation - Euler explicit",[1,0,0],...
        C_Pos_3,C_Vel_3,"Discrete simulation - Euler implicit",[0,0,1]);

else

    d = figure("Name","Solution comparation");
    figure(d);
    comparison_plot_3D(C_Pos_2,C_Vel_2,"Numerical (ode45) solution",[0,1,0],...
        C_Pos_1,C_Vel_1,"Discrete simulation - Euler explicit",[1,0,0]);

end