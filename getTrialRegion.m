function trialRegion = getTrialRegion(onsets, trialRange)

% trialRegion = getTrialRegion(onsets, trialRange)
% -----------------------------------------------------
% This function takes in the vector of trial onset sample numbers and the
% range of samples around each trial, and returns a continuous vector of
% all samples from the start of the first trial epoch through the end of
% the last trial epoch (breaks included).
%
% Therefore, a data matrix using the columns returned by this function will
% have continous data, but lacking the very start and end of the session,
% which appear to be more likely to contain transients.
%
% Uses:
%   Looking for noisy channels during the effective session time
%   Can use as input to ICA for creating the W matrix

trialRegion = (onsets(1) + trialRange(1)):(onsets(end) + trialRange(end));
