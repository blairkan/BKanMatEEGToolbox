function xOut = imputeAllNaN257(xIn, showNeighbors, useOut)
% xOut = imputeAllNan257(xIn, showNeighbors, useOut)
% --------------------------------------------------------------------
% Blair - Jan 22, 2018
%
% This function takes in a channels x time data matrix from any of the
% montages related to the 256-channel net. It looks for NaNs in every
% channel and fills them in the nanmean of its neighbors. Neighboring
% electrode information is read from appropriate
% neighboringElectrodesXYZ.mat file according to the number of rows in the
% input data matrix. If the row size of the input data matrix does not
% match an avaialable neighbors .mat file, the function returns an error.
%
% Note that this function can operate solely on the input data matrix (in
% which case the order in which channels are considered has no effect) or
% can operate iteratively on the output matrix, in which case previously
% imputed values can contribute to subsequent neighbors' imputation. The
% latter case seems to be necessary for certain transients, as the NaN bad
% samples operation will at times Nan out an electrode plus all of its
% neighbors. In the latter case, too, this function can be called more than
% once to assist in imputing all values of the matrix.
%
% NEW FOR THIS VERSION (vs. 125-chan versions): The iterative imputation
% that we used to have to write out as a while loop with catch is now
% hard-coded into this script.
%
% Adapted from xOut = imputeAllNaN125(xIn, [useOut]) Blair Dec 1 2015
% adapted from imputeBadChannels125.m

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

nChannels = size(xIn, 1);

if ~ismember(nChannels, [194 195 212 213 256 257])
    error('The input data frame should contain 194/5, 212/3, or 256/7 rows.')
end

% Load the appropriate .mat file. Variable is always called 'neighbors'.
disp(['Loading neighboringElectrodes' num2str(nChannels) '.mat'])
eval(['load neighboringElectrodes' num2str(nChannels) '.mat'])

xOut = xIn;

if nargin<3, useOut = 0; end
if nargin < 2, showNeighbors = 0; end

c = 1; % Initialize counter in case for some reason we can't impute all
disp(['Number of NaNs: ' num2str(length(find(isnan(xOut)))) '.'])

while length(find(isnan(xOut))) > 0
    
    if c > 5, disp('Unable to impute all NaNs after 5 attempts. Stopping.'); break; end
    
    disp(['Imputing data: Attempt ' num2str(c) '.'])
    
    for ch = 1:size(xOut,1) % Iterate through each electrode
        currNei = neighbors{ch}; % These specify the neighbors (rows)
        currNaN = find(isnan(xIn(ch,:)));  % These specify the NaN time points (columns)      
        if showNeighbors, disp(['Electrode ' num2str(ch) ', neighbors ' mat2str(currNei)]); end
        if useOut % Include recently imputed neighbors in this iteration
            xOut(ch,currNaN) = nanmean(xOut(currNei,currNaN),1);
        else % Stick to current the input matrix as-is
            xOut(ch,currNaN) = nanmean(xIn(currNei, currNaN),1);
        end
    end
    disp(['Number of NaNs: ' num2str(length(find(isnan(xOut)))) '.'])
    c = c+1;
    xIn = xOut; % Update the matrix we are imputing
end
