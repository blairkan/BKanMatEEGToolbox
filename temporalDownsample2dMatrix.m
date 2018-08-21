function xOut = temporalDownsample2dMatrix(xIn, D, electrodeDimension)
% xOut = temporalDownsample2dMatrix(xIn, D, electrodeDimension)
% ------------------------------------------------------------
% Blair - Jan 23, 2017
% This function takes in a 2D electrodes-by-time or time-by-electrodes
% matrix, and temporally downsamples each electrode of data by factor D.
% 
% Inputs
% - xIn: 2D matrix where one dimension is time and one is electrodes
% - D: Downsampling factor. The function will retain every D'th time sample
%   of data from each electrode, starting with time sample 1.
% - electrodeDimension: The dimension number representing electrodes (1 if
%   electrodes are rows; 2 if they are columns). If this argument is
%   omitted, will assume electrodes are dimension 1.
%
% Outputs
% - xOut: 2D matrix, where the time dimension has now been temporally
% downsampled.
%
% Note: This function does NOT decimate - that is, there is no preceding
% lowpass filter step to prevent anti-aliasing.

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

if nargin < 3
    electrodeDimension = 1;
    disp('No electrode dimension entered. Assuming electrode dimension is dimension 1.')
end

if nargin < 2
    error('This function requires at least two input arguments.')
end

% If electrodes are columns, transpose the data so they are temp rows
if electrodeDimension == 2
    xIn = xIn.';
end

% Downsample each electrode of data
for i = 1:size(xIn,1)
    xOut(i,:) = downsample(xIn(i,:), D);
end

% Transpose back if electrodes are columns
if electrodeDimension == 2
    xOut = xOut.';
end