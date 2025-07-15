function holds = continuous_condition(count, K, sigma, beta, init_pos, init_vel)

% Check wether any of the three hypotheses for the continuous model holds.
%
%   count - Count of individuals, used when no initial velocities or
%   positions are set.
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
%   init_vel - Initial velocity matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a velocity of the i-th individuals), 
%   the second dimension can have any size.


    holds = false;
    
    if beta < 0.5
        holds = true;
        return
    elseif beta == 0.5
        if norm(init_vel, "fro") < 0.5 * count * K
            holds = true;
        end
        return
    else
        if third_case_condition(count, K, sigma, beta, norm(init_pos, "fro"), norm(init_vel, "fro")) > 0
            holds = true;
            return
        end
    end
       
    function val = third_case_condition(count, K, sigma, beta, init_pos_norm, init_vel_norm)
        alpha = 2 * beta;
        a = 4 * init_vel_norm^2 / (count * K)^2;
        b = 4 * init_pos_norm^2 + sigma^2;
        val = ((1/alpha)^(1/(alpha - 1)) - (1/alpha)^(alpha/(alpha - 1))) * (1/a)^(1/(alpha - 1)) - b;
    end

end