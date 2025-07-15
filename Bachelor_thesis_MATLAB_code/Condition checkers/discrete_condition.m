function [holds, add_holds] = discrete_condition(count, dt, K, sigma, beta, init_pos, init_vel)

% Check wether any of the three hypotheses for the discrete model holds.
%
%   count - Count of individuals, used when no initial velocities or
%   positions are set.
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
%   init_pos - Initial position matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a position of the i-th individuals), 
%   the second dimension can have any size.
%
%   init_vel - Initial velocity matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a velocity of the i-th individuals), 
%   the second dimension can have any size.

    holds = false;
    add_holds = false;
    
    if beta < 0.5
        holds = true;
        return
    elseif beta == 0.5
        if norm(init_vel, "fro") < 1/(sqrt(2)) * count * K
            holds = true;
        end
        return
    else
        if third_case_condition(count, dt, K, sigma, beta, norm(init_pos, "fro"), norm(init_vel,"fro")) >= 0
            holds = true;
            return
        end
    end

    if add_third_case_condition(count, dt, K, sigma, beta, norm(init_pos, "fro"), norm(init_vel,"fro")) <= 0
        add_holds = true;
    end
       
    function val = third_case_condition(count, dt, K, sigma, beta, init_pos_norm, init_vel_norm)
        a = sqrt(2) * init_vel_norm / (count * K);
        b = sqrt(2) * init_pos_norm + sigma;
        alpha = 2 * beta;
        V = dt * init_vel_norm;
        val = (1/a)^(1/(alpha-1)) * ((1/alpha)^(1/(alpha-1)) - (1/alpha)^(alpha/(alpha-1))) - b - 2*(alpha * a)^(1/(alpha-1)) * (V^2+sqrt(2) * V * ((1/(alpha * a))^(2/(alpha-1)) - sigma^2)^(1/2));
    end

    function val = add_third_case_condition(count, dt, K, sigma, beta, init_pos_norm, init_vel_norm)
        a = sqrt(2) * init_vel_norm / (count*K);
        b = sqrt(2) * init_pos_norm + sigma;
        L = 2*(count-1) * K / (sigma^(2*beta));
        Z = b;
        if (1-b<=a) && (a < 1) && (1<=(1/(2*beta*a))^(1/(2*beta - 1)))
            Z = b / (1 - a);
        end
        val = sigma^2 + 2*(init_pos_norm + dt * init_vel_norm / (2 - dt * L))^2 - Z^2;
    end

end