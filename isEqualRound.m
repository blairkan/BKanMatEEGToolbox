function T = isEqualRound(X1, X2, nDecimals)
% T = isEqualRound(X1, X2 nDecimals)
% ------------------------------------------
% May 2020
% Author: Blair Kaneshiro, blairbo@gmail.com
%
% This function returns whether X1 and X2 are equal when rounded to
%   nDecimals decimal places.

assert(nargin>=2, 'At least 2 variables must be input for comparison.');

if nargin < 3
    warning('Input ''nDecimals'' not specified. Setting to 5');
    nDecimals = 5;
end

T = isequal(round(X1, nDecimals), round(X2, nDecimals));