function x256 = nanFill194to256(x194)
% x256 = nanFill194to256(x194)
% -------------------------------------
% Blair - 22 Dec 2017
%
% This function takes in a vector or matrix with dimension of interest
% being length 194, and returns a vector or matrix with 256 rows. Rows
% representing electrodes excluded from the 194 montage are filled with 
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

% x194 = [1:194; 1001:1194]; % Dev

% Try to get it in 194 rows orientation
if isvector(x194), x194 = x194(:); end
if size(x194,1) ~= 194, x194 = x194.'; end

% clc; size(x194) % Dev

[nrow, ncol] = size(x194);

if nrow ~= 194
    error('One dimension of the input must be length 194.')
end

load mapIndicator194.mat % Cols: 256 #s, 194 #s, indicators
x256 = nan([256 ncol]); % Initialize the output - 256 rows
x256(mapIndicator194(:,3)==1, :) = x194;

% [mapIndicator194 x256] % Dev