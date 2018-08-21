function x257 = nanFill195to257(x195)
% x257 = nanFill195to257(x195)
% -------------------------------------
% Blair - 22 Dec 2017
%
% This function takes in a vector or matrix with dimension of interest
% being length 195, and returns a vector or matrix with 257 rows. Rows
% representing electrodes excluded from the 195 montage are filled with 
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

% x195 = [1:195]; % Dev

% Try to get it in 195 rows orientation
if isvector(x195), x195 = x195(:); end
if size(x195,1) ~= 195, x195 = x195.'; end

% clc; size(x195) % Dev

[nrow, ncol] = size(x195);

if nrow ~= 195
    error('One dimension of the input must be length 195.')
end

load mapIndicator195.mat % Cols: 257 #s, 195 #s, indicators
x257 = nan([257 ncol]); % Initialize the output - 257 rows
x257(mapIndicator195(:,3)==1, :) = x195;

% [mapIndicator195 x257] % Dev