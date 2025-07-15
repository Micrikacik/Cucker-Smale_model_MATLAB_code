function holds = discrete_K_condition(count, dt, K, sigma, beta)

% Check wether the condition for the whole discrete model holds. 
% (The one which prevents oscillation)
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

holds = false;

if K < sigma^(2*beta) / ((count-1)*dt)
    holds = true;
end