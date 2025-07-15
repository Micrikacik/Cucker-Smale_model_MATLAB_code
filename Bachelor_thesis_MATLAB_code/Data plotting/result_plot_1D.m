function [] = result_plot_1D(Pos, Vel, P_Center, C_Pos, timesteps, V_Center, C_Vel, show_center, colors)

arguments
    Pos;
    Vel;
    P_Center;
    C_Pos;
    timesteps = 0:(size(Pos,2)-1);
    V_Center = 0;
    C_Vel = 0;
    show_center = true;
    colors = [];
end

% Plots the result of the experiment_3D.
%
%   Pos - Tensor containing positions of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 1 and third dimension is timestep.
%
%   Vel - Tensor containing velocities of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 1 and third dimension is timestep.
%
%   P_Center - Tensor containing positions of the center of the group 
%   of the whole simulation as "vectors stacked
%   behind eachother", i.e., first dimension has size 1, second
%   dimension is 1 and third dimension is timestep.
%
%   C_Pos - Tensor containing relative positions with respect to the center 
%   of the group of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 1 and third dimension is timestep.
%
%   timesteps - Time points in which were the data obtained.
%
%   V_Center - Tensor containing arithmetic means of the velocities of the whole 
%   simulation as "vectors stacked behind eachother", i.e., first dimension 
%   is 1, second dimension is 1 and third dimension is timestep.
%
%   C_Vel - Tensor containing relative velocity deviations with respect to their 
%   arithmetic mean of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 1 and third dimension is timestep.
%
%   show_center - Decides wether to show the arithmetic mean of positions
%   and velocities in their respective figures.
%
%   colors - Colors for individuals when plotting the graph, it's a matrix
%   with "count" rows and 3 columns (rgb triplet for each individual).



tiles = 3;

if isequal(C_Vel, 0) == false
    tiles = tiles + 1;
end

tiledlayout(1,tiles)



if length(colors) < size(Pos,1)
    colors = rand(size(Pos,1),3); % rgb triplet
end



nexttile
data_plot_1D(Pos,timesteps,colors,"Absolute positions","Position in space")
if show_center == true
    center_plot_1D(P_Center,timesteps)
end

nexttile
data_plot_1D(C_Pos,timesteps,colors,"Relative positions","Position from center")

nexttile
data_plot_1D(Vel,timesteps,colors,"Absolute velocities","Velocity")



if (show_center == true) && (isequal(V_Center, 0) == false)
    center_plot_1D(V_Center,timesteps)
end



if isequal(C_Vel, 0) == false
    nexttile
    data_plot_1D(C_Vel,timesteps,colors,"Relative velocities","Velocity deviation")
end

function [] = center_plot_1D (m_center, timesteps)
    hold on
    plot(permute(m_center(1,1,:),[3 2 1]),timesteps,['o','k'],'MarkerSize',10)
    hold off