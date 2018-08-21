function xOut = chRows2cube(xIn, N)
% ----------------------------------
% xOut = chRows2cube(xIn, N)
% Blair - July 4, 2016
%
% This function takes a 2D electrodes x concatenated trials matrix and
% reshapes it to a 3D electrodes x time x trials matrix.
%
% The number of columns in xIn must be an integer multiple of N (integer
% number of trials.) The function will return an error if this is not the
% case.
%
% See also trRows2cube ch2trRows tr2chRows cube2trRows cube2chRows

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2016 Blair Kaneshiro
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

% Check to make sure that it's an integer number of trials
nTr = size(xIn, 2)/N;
if rem(nTr, 1) ~= 0
   error('Number of columns in input is not integer divisible by N.');
end

nCh = size(xIn, 1);
xOut = nan(nCh, N, nTr);

for i = 1:nTr
   currCols = (i-1)*N + (1:N);
   xOut(:,:,i) = xIn(:,currCols);
   clear curr*
end