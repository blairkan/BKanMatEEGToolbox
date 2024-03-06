function r = computeCorrelationsWithNeighboringElectrodes(xIn)
% r = computeNeighborCorrelations(xIn)
% ---------------------------------------------
% Blair - March 6, 2024
%
% This function takes in a data matrix and computes the correlation of each
% electrode's data with its neighbors.
%
% Input (required)
% - xIn: An [electrode x time] matrix. The number of electrodes should
%   correspond to one of the neighboringElectrodes###.mat files in the
%   repository where this function lives. 
%
% Output
% - r: Vector of correlations, where element r(i) indicates the mean
%   correlation of electrode i with all of its neighbors.

% Assert correct number of inputs
assert(nargin == 1, 'This function requires one input, an electrode x time EEG matrix.')

% Number of electrodes
nElectrodes = size(xIn, 1); 