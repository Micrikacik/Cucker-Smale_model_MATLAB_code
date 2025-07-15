function [] = comparison_plot_1D(Pos_arr, Vel_arr, timesteps_arr, legend_arr, color_arr)

% Plots results from multiple 1D experiments into one figure, where the
% experiments are distiguished by color 
% (individuals from one experiment have the same color). 
% The "_arr" is only for the purposes of this script.
%
%   Pos_arr - Tensor containing positions of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 1 and third dimension is timestep.
%
%   Vel_arr - Tensor containing velocities of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 1 and third dimension is timestep.
%
%   timesteps_arr - Time points in which were the data obtained.
%
%   legend_arr - Name of the experiment.
%
%   color_arr - Color of the experiment.

arguments (Repeating)
    Pos_arr;
    Vel_arr;
    timesteps_arr;
    legend_arr;
    color_arr;
end


tiledlayout(1,2)


input_count = size(Pos_arr,2);
count = size(Pos_arr{1},1);


nexttile
for i = 1:input_count
    Pos = Pos_arr{i};
    timesteps = timesteps_arr{i};
    i_legend = legend_arr{i};
    i_color = color_arr{i};

    i_colors = [ones(count,1) * i_color(1), ...
        ones(count,1) * i_color(2), ...
        ones(count,1) * i_color(3)];
    
    data_plot_1D(Pos,timesteps,i_colors,"Positions comparison","Position from center",':','.','o',i_legend)
end


nexttile
for i = 1:input_count
    Vel = Vel_arr{i};
    timesteps = timesteps_arr{i};
    i_legend = legend_arr{i};
    i_color = color_arr{i};

    i_colors = [ones(count,1) * i_color(1), ...
        ones(count,1) * i_color(2), ...
        ones(count,1) * i_color(3)];
    
    data_plot_1D(Vel,timesteps,i_colors,"Velocities comparison","Velocity deviation",':','.','o',i_legend)
end

