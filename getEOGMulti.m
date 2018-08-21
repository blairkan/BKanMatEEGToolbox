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

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2015 Blair Kaneshiro
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, 
% this list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright notice, 
% this list of conditions and the following disclaimer in the documentation 
% and/or other materials provided with the distribution.
% 
% 3. Neither the name of the copyright holder nor the names of its 
% contributors may be used to endorse or promote products derived from this 
% software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ?AS IS?
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.

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