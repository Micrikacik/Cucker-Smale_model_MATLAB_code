function values = evaluate_approximation(data, data_timesteps, eval_timesteps)
    
    % Evaluates in time points given by eval_timesteps using linear interpolation. 
    % 
    %   data - Tensor of data, first two dimensions are data, third
    %   dimension is index of a time point from data_timesteps, in which
    %   were the data obtained.
    %
    %   data_timesteps - Time points corresponding to the third dimension
    %   of data, in which were the data obtained.
    %
    %   eval_timesteps - Time point in which the data will be linearly
    %   interpolated.
    %
    % Output:
    %
    %   values - Tensor of data, first two dimensions are data, third
    %   dimension is index of a time point from eval_timesteps, in which
    %   were the data linearly interpolated.
    
    values = zeros(size(data,1),size(data,2),length(eval_timesteps));

    for i = 1:length(eval_timesteps)
        eval_t = eval_timesteps(i);

        index_data_t_bef = 1;
        data_t_bef = data_timesteps(1);
        index_data_t_aft = 1;
        data_t_aft = data_timesteps(1);

        for index_data_t = 1:length(data_timesteps)
            data_t = data_timesteps(index_data_t);
            if data_t >= eval_t
                index_data_t_aft = index_data_t;
                data_t_aft = data_t;
                break
            end
            index_data_t_bef = index_data_t;
            data_t_bef = data_t;
        end

        data_bef = data(:,:,index_data_t_bef);
        data_aft = data(:,:,index_data_t_aft);
    
        val = interpolate({data_bef, data_aft}, [data_t_bef, data_t_aft], eval_t);

        values(:,:,i) = val;
    end
    
    function inter = interpolate(data, interval, point)
        % interval should be an 1x2 array and it should contain point
        % data shoulb be an 1x2 cell
        work_point = transform(point, -interval(1), 1/(interval(2) - interval(1)), 0);
        inter = work_point*data{2} + (1-work_point)*data{1};
    
        function res = transform(value, translation_1, scale, translation_2)
            res = (value + translation_1) * scale + translation_2;
        end
    end
end