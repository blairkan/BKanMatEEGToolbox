function x257 = nanFill213to257(x213)
% x257 = nanFill213to257(x213)
% -------------------------------------
% Blair - 22 Dec 2017
%
% This function takes in a vector or matrix with dimension of interest
% being length 213, and returns a vector or matrix with 257 rows. Rows
% representing electrodes excluded from the 213 montage are filled with 
% NaN.

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2017 Blair Kaneshiro
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

% x213 = [1:213; 1001:1213]; % Dev

% Try to get it in 213 rows orientation
if isvector(x213), x213 = x213(:); end
if size(x213,1) ~= 213, x213 = x213.'; end

% clc; size(x213)

[nrow, ncol] = size(x213);

if nrow ~= 213
    error('One dimension of the input must be length 213.')
end

load mapIndicator213.mat % Cols: 257 #s, 213 #s, indicators
x257 = nan([257 ncol]); % Initialize the output - 257 rows
x257(mapIndicator213(:,3)==1, :) = x213;

% [mapIndicator213 x257]