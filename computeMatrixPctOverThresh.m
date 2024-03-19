function [pctOverThresh, iMatrix] = computeMatrixPctOverThresh(xIn, thresh)
% [pctOverThresh, iMatrix] = computeMatrixPctOverThresh(xIn, thresh)
% -------------------------------------------------
% Blair - March 19, 2024
%
% This matrix computes the percent of (magnitude) values in a matrix that
% are over a specified threshold. 
%
% Inputs (required)
% - xIn: A data matrix. The input data are assumed to be space x time since
%   the function returns a percent over threshold for each row (channel). 
% - thresh: A threshold. Flagged values will be strictly greater than this
%   threshold (not geq).
%
% Outputs
% - pctOverThresh: The percent over threshold for each row (channel) of the
%   input data. 
% - iMatrix: The indicator matrix from which the percentage was computed. 

%% Check inputs

assert(nargin == 2, 'This function requires two inputs: A data matrix and a threshold.')

%% Do the stuff

% Create an indicator matrix to capture values of the input whose magnitude
% (absolute value) strictly exceed the specified threshold. 
iMatrix = abs(xIn) > thresh; 
pctOverThresh = 100 * sum(iMatrix, 2) / size(iMatrix, 2);