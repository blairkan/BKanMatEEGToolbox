function iscMatrix = computeISCMatrix(X)
% iscMatrix = computeISCMatrix(X)
% ----------------------------------------
% Blair - Februaray 2021
%
% This function takes in a time x trials data matrix, and computes the ISC
%   among the trials. It returns a correlation matrix for which the
%   diagonal has been set to NaNs.
%
% INPUT: X -- a time x trials data matrix
% OUTPUT: iscMatrix -- a square trial x trial matrix. Element i, j contains
%   the correlation between trial i and trial j. The diagonal has been
%   replaced with NaNs to facilitate subsequent averaging.

xCorr = corr(X);
iscMatrix = xCorr + diag(nan(size(diag(xCorr))));