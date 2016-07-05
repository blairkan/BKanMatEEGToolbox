function [VEOG, HEOG] = getEOGMulti(x129, VEOG1, VEOG2, HEOG1, HEOG2)

% [VEOG, HEOG] = getEOGMulti(x129, VEOG1, VEOG2, HEOG1, HEOG2)
% -----------------------------------------------------------------
% Blair - August 19, 2015
%
%
% Adapted from getEOG(x129, VEOGchannels, HEOGchannels)
% Blair - May 6, 2014
% Function takes in the 129 x N data matrix, channel numbers used to 
% compute both VEOG and HEOG, and returns column vectors of VEOG
% and HEOG channels for artifact removal.
%
% Example usage
%   - VEOG = 8 - 126
%   - HEOG = (1 + 125)/2 - (32+128)/2
%   - [v, h] = getEOGMulti(x129, 8, 126, [1 125], [32 128])
%
% Inputs
%   - x129: Data frame with 129 channels
%   - VEOG*, HEOG*: Numbers or vectors for EOG components such that we take
%   the difference of *EOG1 and *EOG2
%
% See also getEOG

if size(x129, 1) ~= 129
    error('Data matrix for computing EOG must contain 129 rows.')
end

if nargin<5
    error('Please provide the data matrix, as well as 2 arguments for each VEOG and HEOG component.')
end

v1 = VEOG1
v2 = VEOG2
h1 = HEOG1
h2 = HEOG2

% Compute VEOG and HEOG from x129
if isempty(v2)
    VEOG = mean(x129(v1,:),1);
else
    VEOG = mean(x129(v1,:),1) - mean(x129(v2,:),1);
end

if isempty(h1)
    HEOG = mean(x129(h2,:),1);
elseif isempty(h2)
    HEOG = mean(x129(h1,:), 1);
else
    HEOG = mean(x129(h1,:),1) - mean(x129(h2,:),1);
end
% Make sure they are columns
VEOG = VEOG(:);
HEOG = HEOG(:);