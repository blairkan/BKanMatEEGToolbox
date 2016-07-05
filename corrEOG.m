function [corrV, corrH, aboveThreshold] = corrEOG(data, VEOG, HEOG, thresh)

% [corrV, corrH, aboveThreshold] = corrEOG(data, VEOG, HEOG, thresh)
% -----------------------------------------------------
% Blair - May 7, 2014
% Compute and plot the correlations of each ICA source signal with the VEOG
% and HEOG channels. Display in the console window the sources whose
% correlation magnitude is greater than or equal to the threshold.
%
% Inputs
%   - Data frame (EEG in ICA space, each channel is a COLUMN)
%   - VEOG data channel
%   - HEOG data channel
%   - [optional] Correlation threshold
% If no fourth argument is supplied, the function uses a default threshold
% of 0.3
%
% Outputs
%   - Vector of VEOG correlation coefficients
%   - Vector of HEOG correlation coefficients
%   - Vector of source numbers exceeding correlation threshold

if nargin == 3
    thresh = 0.3;
end

% Make sure the data matrix passed in has more rows than columns
if size(data,1) < size(data,2)
    disp('Transposing the data matrix');
    data = data.';
end

HEOG = HEOG(:);
VEOG = VEOG(:);

corrH = corr(data, HEOG);
corrV = corr(data, VEOG);

aboveThreshold = find(abs(corrH) >= thresh | abs(corrV) >= thresh);