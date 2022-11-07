function startStopIdx = convertTrialLenToStartStopIdx(trialLens, totalLen)
% startStopIdx = convertTrialLenToStartStopIdx(trialLens)
% -------------------------------------------------------------------
% Blair - November 7, 2022
%
% This function takes in a vector of trial lengths and converts it to a 
% matrix of start and stop indices. These indices can then be used to epoch
% concatenated trials.
%
% Inputs
% - trialLens(required): Vector of trial lengths. Can be a row or column.
% - totalLen (optional): Total length of data. If entered, the function
%   will assert that the last entry in the output matrix is equal to this.
%   Can be useful to confirm proper epoching of a concatenated matrix.
%
%
% Ouput
% startStopIdx: nTrial x 2 matrix. Each row contains the sample index of
% the start and stop, assuming all trials were concatenated into a single
% matrix. 
%
% Example function call
%   trialLens = [5 100 23];
%   startStopIdx = convertTrialLenToStartStopIdx(trialLens)

%% Check for required input

assert(nargin >= 1, 'One input is required: Vector of trial lengths.')

%% Create the matrix from the input vector

trialLens = trialLens(:);
nTrials = length(trialLens);
startStopIdx = nan(nTrials, 2);

% Start with column 2: Cumulative total number of samples
startStopIdx(:, 2) = cumsum(trialLens);

% Column 1 continues where each previous row left off
startStopIdx(1, 1) = 1;
startStopIdx(2:end, 1) = startStopIdx(1:(end-1), 2) + 1;

%% Confirm total length if two inputs were given

if nargin == 2
    assert(isequal(startStopIdx(end, end), totalLen), ...
        ['Last entry of start-stop matrix (' num2str(startStopIdx(end, end)) ...
        ') does not equal specified total length (' num2str(totalLen) ')!'])
end