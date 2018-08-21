function x129 = nanFill127To129(x127)
% x129 = nanFill127To129(x127)
% --------------------------------------
% Blair - May 24, 2018
% This function takes in a vector of length 127 (presumed to be from
% channels 1:125, 128, plus reference), adds rows for missing channels
% 126:127 and returns a length-129 vector (reference at 129) for input to
% plotOnEGI129 function.

% Adapted from x129 = nanFill125To129(x125) Blair - March 9, 2016 UPDATED May 24, 2018

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2018 Blair Kaneshiro
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

% Try to get it in 127 rows orientation
if isvector(x127), x127 = x127(:); end
if size(x127, 1) ~= 127, x127 = x127.'; disp('nanFill127to129: Transposing input data.'); end

[nrow, ncol] = size(x127);

if nrow ~= 127
    error('One dimension of the input must be length 127.');
end

load mapIndicator127.mat
x129 = nan(129, ncol); % Initialize output - 129 rows
x129(mapIndicator127(:,3) == 1,:) = x127;