function fIdx = computeFFTBinsSelectedFrequencies(fAx, fUse, rtnAll)
% fIdx = computeFFTBinsSelectedFrequencies(fAx, fUse, rtnAll)
% -------------------------------------------------------------
% Creator: Blair Kaneshiro (October 2022)
%
% This function takes in an FFT frequency axis (vector of bins, in Hz) and
% vector of frequencies of interest, and returns the bins corresponding to
% the frequencies of interest. 
%
% Inputs (required)
% - fAx: Frequency axis (vector of bins, in Hz). The current implementation
%   requires this input to have an even number of entries.
% - fUse: Vector of frequencies of interest, in Hz.
%
% Input (optional)
% - rtnAll: Specification of whether to return indices of all frequencies
%   (true, positive and negative) or only the positive frequencies (false).
%   If not entered or empty, will default to true.
%
% Output
% - fIdx: Vector of indices corresponding to frequencies of interest. Note
%   that the entries of fIdx are ascending for positive frequencies and, if
%   negative frequencies are returned, descending for negative frequencies.
%   This maintains conjugate correspondence in the ordering of elements in
%   the first and second halves of outputs including negative frequencies.
%
% NOTE: It is the responsibility of the user to ensure that all frequencies
% of interest (fUse) correspond exactly to entries in the full frequency
% axis (fAx).
%
% See also: computeFFTFrequencyAxis

%% Input checks

% Make sure there are at least 2 inputs
assert(nargin >= 2, ...
    ['At least 2 inputs are required: The full frequency axis, '...
    'and a vector containing one or more frequencies of interest.'])

% Assign third input if not specified
if nargin < 3 || isempty(rtnAll), rtnAll = true; end

% Make sure the length of the frequency axis is even
assert(~rem(length(fAx), 2), ...
    'Input frequency axis must have an even number of entries.')

%% Get frequency indices

% Get indices of positive frequencies first
thisFIdx1 = find(ismember(fAx, fUse));

% If returning all, also get indices of negative frequencies
if rtnAll
    
    % Get indexes of corresponding negative frequencies.
    thisFIdx2 = length(fAx) - (thisFIdx1 - 2);
    
else, thisFIdx2 = [];
end

% Combine the two
fIdx = [thisFIdx1(:); thisFIdx2];