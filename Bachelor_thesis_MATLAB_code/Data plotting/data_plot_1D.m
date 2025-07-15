function [] = data_plot_1D (data, timesteps, colors, plot_title, x_label, line_style, step_style, origin_style, data_legend)
    
    arguments
        data;
        timesteps;
        colors;
        plot_title = "Data plot";
        x_label = "Position in space"
        line_style = ':';
        step_style = '.';
        origin_style = 'o';
        data_legend = "None"
    end

% Plots data (positions/velocities) from the simulation/aproximation into 
% a 1D figure. This shows only both positions/velocities and time points.
%
%   data - Tensor containing data of the whole simulation as "matrices stacked
%   behind eachother", i.e., first dimension is index of individual, second
%   dimension is 1 and third dimension is index of a time point 
%   in which were the data obtained (in this plot the time points are not visible).
%
%   timesteps - Time points in which were the data obtained.
%
%   colors - Colors for individuals, it's a matrix
%   with "count" rows and 3 columns (rgb triplet for each individual).
%
%   plot_title - Title of the plot.
%
%   line_style - Style of the line between steps.
%
%   step_style - Style of the points of steps.
%
%   origin_style - Style of the initial value.
%
%   data_legend - Legend for the plotted data. Plots are done by
%   individuals.

    count = size(data,1);
    title(plot_title)
    hold on
    for i = 1:count
        color = colors(i,:);

        column_data = permute(data(i,1,:),[3 2 1]);

        % line
        if (data_legend == "None") || (i ~= 1)
        plot(column_data,timesteps,step_style,'Color',color)
        else
            legend('AutoUpdate','on')
            plot(column_data,timesteps,step_style,'Color',color,'DisplayName',data_legend)
            legend('AutoUpdate','off')
        end

        % timesteps
        plot(column_data,timesteps,line_style,'Color',color)
        
        % origin
        plot(data(i,1,1),0,origin_style,'Color',color) 
    end

    xlabel(x_label);
    ylabel("Time point");
    hold off