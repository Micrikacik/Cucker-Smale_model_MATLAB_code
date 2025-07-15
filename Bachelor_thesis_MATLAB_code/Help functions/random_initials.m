function [X,V] = random_initials(count, dim, pos_spread, vel_spread)

% Generates random initial conditions in correct format.
%
%   count - Count of the individuals.
%
%   dim - Dimension of space in which the individuals are.
%
%   pos_spread - Size of the dim-dimensional hypercube from which 
%   the random positions are taken.
%
%   vel_spread - Size of the dim-dimensional hypercube from which 
%   the random velocities are taken.

X = (rand(count, dim)-0.5)*2*pos_spread;
V = (rand(count, dim)-0.5)*2*vel_spread;