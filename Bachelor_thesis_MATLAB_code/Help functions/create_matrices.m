function [L_x, A_x, D_x] = create_matrices(X, K, sigma, beta)

% Creates matrices for the model.
%
%   X - Position matrix where first dimension is index of individual 
%   and second dimension is coordinate (i-th row is a position of the i-th individuals), 
%   the second dimension can have any size.
%
%   K - Parameter of the model.
%
%   sigma - Parameter of the model.
%
%   beta - Parameter of the model.
%
% Output:
%
%   L_x - Same as matrix from the model.
%
%   A_x - Same as matrix from the model.
%
%   D_x - Same as matrix from the model.

count = size(X,1);

eta = @(x,y) K/(sigma^2+norm(x-y)^2)^beta;
A_x = zeros(count);
D_x = zeros(count);

for i = 1:count
    for j = 1:count
        A_x(i,j) = eta(X(i,:),X(j,:));
    end
end

for i = 1:count
    D_x(i,i) = sum(A_x(i,:));
end

L_x = D_x-A_x;

