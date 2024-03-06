function [rVec, rCell] = computeCorrelationsWithNeighboringElectrodes(xIn, forceNNeighbors)
% [rVec, rCell] = computeCorrelationsWithNeighboringElectrodes(xIn, forceNNeighbors)
% ---------------------------------------------
% Blair - March 6, 2024
%
% This function takes in a data matrix and computes the correlation of each
% electrode's data with its neighbors.
%
% Input
% - xIn (required): An [electrode x time] matrix. The number of electrodes 
%   should correspond to one of the neighboringElectrodes###.mat files in 
%   the repository where this function lives. 
% - forceNNeighbors (optional): An integer indicating the number of
%   electrodes to consider in the correlation calculations. For instance, a
%   user may input a 129-channel matrix but only be interested in the
%   neighbor correlations for channels 1:128 or 1:124. This value, if
%   entered, will influence both the neighboring electrodes struct loaded
%   and the number of correlations performed. 
%
% Output
% - rVec: Vector of correlations, where element r(i) indicates the mean
%   correlation of electrode i with all of its neighbors.
% - rCell: Cell array of correlations, storing each individual pairwise
%   channel correlation.

% Assert correct number of inputs
assert(nargin >= 1, ...
    'This function requires at least one input, an electrode x time EEG matrix.')

% Number of electrodes to look at
nElectrodes = size(xIn, 1); 
if nargin == 2
    assert(forceNNeighbors <= size(xIn,1), ...
        ['User requests neighbors based on ' num2str(forceNNeighbors) ...
        ' electrodes, but input data has only ' num2str(nElectrodes) ' electrodes.'])
    nElectrodes = forceNNeighbors;    
end

% Load the appropriate neighboring electrodes struct
neighborFnIn = ['neighboringElectrodes' num2str(nElectrodes) '.mat'];
load(neighborFnIn);
disp(['Computing neighbor correlations for ' num2str(nElectrodes) ' electrodes.'])

% Initialize the outputs
rVec = nan(nElectrodes, 1);
rCell = cell(nElectrodes, 1);

% Iterate through each electrode
for i = 1:nElectrodes

    % Get current neighbors
    thisNei = neighbors{i}; 
    
    % Get current NUMBER of neighbors
    thisNNei = length(thisNei);

    % Initialize the correlations for current neighbors
    thisNeiCorr = nan(thisNNei, 1);

    % Now iterate through the neighbors, correlating the current electrode
    % with a given neighbor
    for j = 1:thisNNei
        thisNeiCorr(j) = corr(xIn(i,:)', xIn(thisNei(j),:)');
    end

    rVec(i) = mean(thisNeiCorr);
    rCell{i} = thisNeiCorr;

    clear this*
end