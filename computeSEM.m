function sem = computeSEM(x, dim)
% sem = computeSEM(x)
% --------------------------
% Creator: Blair Kaneshiro (Nov 2022)
%
% This function takes in a vector or matrix of data, and computes the
% standard error of the mean.
%
% For N observations, SEM = std(x) / sqrt(N)
%
% Inputs:
% - x (required): Input data matrix or vector
% - dim (optional): For 2d input data, along which dimension to compute
%   SEM. If the input x is a matrix *and* this input is empty or not
%   entered, the function will compute SEM along the row dimension (one
%   value per column of data).

%% Check inputs

assert(nargin >= 1, 'At least one input, x, is required.');

%% Compute SEM

% If input is a vector
if isvector(x)
    s = std(x);
    l = length(x);

% If input is a matrix
else
    
    if nargin < 2 || isempty(dim), dim = 1; end
    
    s = std(x, [], dim);
    l = size(x, dim);
    
end

% Compute SEM
sem = s / sqrt(l);