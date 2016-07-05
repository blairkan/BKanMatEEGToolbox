function trialCols = getTrialCols(onsets, range)

% trialCols = getTrialCols(onsets, range)
% ----------------------------------------
% Blair - May 6, 2014
% Trial epoching for fixed range of samples for each trial.
% Inputs:
%   onsets - vector of trial onsets
%   range - range of samples around onsets to include, where 0 is the
%   onset.
%      example: 0:5 will include the onset and 5 samples following
% Output: Vector of columns in which trials occurred.

trialCols = reshape(bsxfun(@plus, onsets(:)', range(:)), 1, []);