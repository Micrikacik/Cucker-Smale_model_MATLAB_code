function [] = result_plot_3D(Pos, Vel, P_Center, C_Pos, V_Center, C_Vel, show_center, colors)

arguments
    Pos;
    Vel;
    P_Center;
    C_Pos;
    V_Center = 0;
    C_Vel = 0;
    show_center = true;
    colors = [];
end

% Plots the result of the experiment_3D.
%
%   Pos - Tensor containing positions of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 3 and third dimension is timestep.
%
%   Vel - Tensor containing velocities of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 3 and third dimension is timestep.
%
%   P_Center - Tensor containing positions of the center of the group 
%   of the whole simulation as "vectors stacked
%   behind eachother", i.e., first dimension has size 1, second
%   dimension is 3 and third dimension is timestep.
%
%   C_Pos - Tensor containing relative positions with respect to the center 
%   of the group of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 3 and third dimension is timestep.
%
%   V_Center - Tensor containing arithmetic means of the velocities of the whole 
%   simulation as "vectors stacked behind eachother", i.e., first dimension 
%   is 1, second dimension is 3 and third dimension is timestep.
%
%   C_Vel - Tensor containing relative velocity deviations with respect to their 
%   arithmetic mean of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 3 and third dimension is timestep.
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
data_plot_3D(Pos,colors,"Absolute positions")
if show_center == true
    center_plot_3D(P_Center)
end

nexttile
data_plot_3D(C_Pos,colors,"Relative positions")

nexttile
data_plot_3D(Vel,colors,"Absolute velocities")


if (show_center == true) && (isequal(V_Center, 0) == false)
    center_plot_3D(V_Center)
end



if isequal(C_Vel, 0) == false
    nexttile
    data_plot_3D(C_Vel,colors,"Relative velocities")
end

function [] = center_plot_3D (m_center)
    hold on
    x_data = permute(m_center(1,1,:),[3 2 1]);
    y_data = permute(m_center(1,2,:),[3 2 1]);
    z_data = permute(m_center(1,3,:),[3 2 1]);
    plot3(x_data,y_data,z_data,['o','k'],'MarkerSize',10)
    hold off