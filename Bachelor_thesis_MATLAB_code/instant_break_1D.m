function [] = instant_break_1D()

% Specific setings for the discrete model used in the section Model
% Showcase in the thesis.

X = [-3; 3];
V = 40 * [1; -1];

h1 = 1;
h2 = 0.5;
h3 = 2;

iter = 60;

iter1 = floor(iter / h1);
iter2 = floor(iter / h2);
iter3 = floor(iter / h3);

K = sqrt(10);
sigma = 2;
beta = 0.5;

[~, C_Pos_1, ~, ~, C_Vel_1, ~] = experiment(iter1, h1, K, sigma, beta, X, V);
timesteps_1 = (0:(size(C_Pos_1,3)-1))*h1;

[~, C_Pos_2, ~, ~, C_Vel_2, ~] = experiment(iter2, h2, K, sigma, beta, X, V);
timesteps_2 = (0:(size(C_Pos_2,3)-1))*h2;

[~, C_Pos_3, ~, ~, C_Vel_3, ~] = experiment(iter3, h3, K, sigma, beta, X, V);
timesteps_3 = (0:(size(C_Pos_3,3)-1))*h3;


comparison_plot_1D(C_Pos_1,C_Vel_1,timesteps_1,"h = " + h1,[1,0,0], ...
    C_Pos_2,C_Vel_2,timesteps_2,"h = " + h2,[0,1,0], ...
    C_Pos_3,C_Vel_3,timesteps_3,"h = " + h3,[0,0,1]);