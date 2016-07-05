function xBL = baselineCorrect(xIn, samps)

% xBL = baselineCorrect(xIn, samps)
% -----------------------------------
% Blair - Oct. 19, 2015
% This function takes in the channels x time EEG data matrix X and returns
% an output matrix xBL, whose rows have been baseline corrected by
% subtracting from each row the mean of voltages indexed by samps.
%
% Typically xIn is one trial of data, and samps indexes the sample numbers
% corresponding to the pre-stimulus or < 50ms post-stimulus interval.

xBL = xIn - repmat(mean(xIn(:,samps),2), 1, size(xIn,2));