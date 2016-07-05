function [VEOG, HEOG] = getEOG(x129, VEOGchannels, HEOGchannels)

% [VEOG, HEOG] = getEOG(x129, VEOGchannels, HEOGchannels)
% ---------------------------------------------
% Blair - May 6, 2014
% Function takes in the 129 x N data matrix, channel numbers used to 
% compute both VEOG and HEOG, and returns column vectors of VEOG
% and HEOG channels for artifact removal.
%
% Inputs
%   - x129: Data frame with 129 channels
%   - VEOGchannels: Vector of two VEOG channels (e.g., [8 126])
%   - HEOGchannels: Vector of two HEOG channels (e.g., [125 128])
%
% See also getEOGMulti

if size(x129, 1) ~= 129
    error('Data matrix for computing EOG must contain 129 rows.')
end

if nargin<3
    error('Please provide the data matrix, as well as VEOG and HEOG channel assignments.')
end

v1 = VEOGchannels(1)
v2 = VEOGchannels(2)
h1 = HEOGchannels(1)
h2 = HEOGchannels(2)

% Compute VEOG and HEOG from x129
VEOG = x129(v1,:) - x129(v2,:);
HEOG = x129(h1,:) - x129(h2,:);
% Make sure they are columns
VEOG = VEOG(:);
HEOG = HEOG(:);