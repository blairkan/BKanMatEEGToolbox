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
% See also getEOGMulti computeEOG129 computeEOG256

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2014 Blair Kaneshiro
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