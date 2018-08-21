function xOut = imputeAllNaN125(xIn, useOut)

% xOut = imputeAllNaN125(xIn, [useOut])
% ---------------------------------------------
% Blair - December 1, 2015 - adapted from imputeBadChannels125.m
% 
% This function takes in a 125-channels x time data matrix and list of bad
% channels. It looks for NaNs in every channel and fills them in the 
% nanmean of its neighbors. Neighboring electrode information is read from 
% neighboringElectrodes125.mat.
%
% Note that this function can operate solely on the input data matrix (in 
% which case the order in which channels are considered has no effect) or 
% can operate iteratively on the output matrix, in which case previously
% imputed values can contribute to subsequent neighbors' imputation. The
% latter case seems to be necessary for certain transients, as the NaN bad
% samples operation will at times Nan out an electrode plus all of its
% neighbors. In the latter case, too, this function can be called more than
% once to assist in imputing all values of the matrix.

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

warning('This function is deprecated. Function ''imputeAllNaN129'' recommended for montages derived from 128-chan net.')

% Load struct with 'neighbors' variable.
load neighboringElectrodes125.mat;

xOut = xIn;

if nargin<2
    useOut = 1;
end

for i = 1:size(xOut,1)
   % Get indices of NaN data in current electrode (columns of interest)
   currNaN = find(isnan(xIn(i,:))); 
   % Get neighbors of current electrode
   currNei = neighbors{i};
   if useOut
       xOut(i,currNaN) = nanmean(xOut(currNei,currNaN),1);
   else
       xOut(i,currNaN) = nanmean(xIn(currNei, currNaN),1);
   end
end
