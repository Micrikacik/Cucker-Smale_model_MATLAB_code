function [C_Pos, C_Vel, P_Center, V_Center] = calculate_centers(Pos, Vel)

% Calculates arithmetic means and deviations of the positions and
% velocities.
%
%   Pos - Tensor containing positions of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep.
%
%   Vel - Tensor containing velocities of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep.
%
% Output:
%
%   C_Pos - Tensor containing relative positions with respect to the center 
%   of the group of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep.
%
%   P_Center - Tensor containing positions of the center of the group 
%   of the whole simulation as "vectors stacked
%   behind eachother", i.e., first dimension has size 1, second
%   dimension is coordinate and third dimension is timestep.
%
%   C_Vel - Tensor containing relative velocity deviations with respect to their 
%   arithmetic mean of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is coordinate and third dimension is timestep.
%
%   V_Center - Tensor containing arithmetic means of the velocities of the whole 
%   simulation as "vectors stacked behind eachother", i.e., first dimension 
%   is 1, second dimension is coordinate and third dimension is timestep.

count = size(Pos,1);

P_Center = sum(Pos)/count;

C_Pos = zeros(size(Pos));

for i = 1:count
    C_Pos(i,:,:) = Pos(i,:,:) - P_Center;
end

V_Center = sum(Vel)/count;

C_Vel = zeros(size(Vel));

for i = 1:count
    C_Vel(i,:,:) = Vel(i,:,:) - V_Center;
end