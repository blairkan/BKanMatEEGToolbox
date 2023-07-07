function xOut = imputeAllNaN74_128(xIn, showNeighbors, useOut)
% xOut = imputeAllNaN74_128(xIn, showNeighbors, useOut)
% --------------------------------------------------------------------
% Blair - Feb 15, 2019
%
% This function takes in a channels x time data matrix from a 74- or 
% 128/129- channel montage. It looks for NaNs in every
% channel and fills them in the nanmean of its neighbors. Neighboring
% electrode information is read from appropriate
% neighboringElectrodes###.mat file according to the number of rows in the
% input data matrix. If the row size of the input data matrix does not
% match an avaialable neighbors .mat file, the function returns an error.
%
% Current montages: 72, 128/129.
%
% Note that this function can operate solely on the input data matrix (in
% which case the order in which channels are considered has no effect) or
% can operate iteratively on the output matrix, in which case previously
% imputed values can contribute to subsequent neighbors' imputation. The
% latter case seems to be necessary for certain transients, as the NaN bad
% samples operation will at times NaN out an electrode plus all of its
% neighbors. In the latter case, too, this function can be called more than
% once to assist in imputing all values of the matrix.
%
% NEW FOR THIS VERSION (vs. imputeAllNan125): The iterative imputation
% that we used to have to write out as a while loop with catch is now
% hard-coded into this script.

% Adapte4d from imputeAllNan129(xIn, showNeighbors, useOut)
%   Blair May 28, 2018
% Adapted from xOut = imputeAllNan257(xIn, showNeighbors, useOut) 
%         Blair - Jan 22, 2018
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

if ~ismember(nChannels, [74, 124, 128, 129])
    error('The input data frame should contain 74, 124, 128, or 129 rows.')
end

% Load the appropriate .mat file. Variable is always called 'neighbors'.
disp(['Loading neighboringElectrodes' num2str(nChannels) '.mat'])
eval(['load neighboringElectrodes' num2str(nChannels) '.mat'])
 
if nargin < 3, useOut = 1; end
if nargin < 2, showNeighbors = 0; end

%%%% NEW for this version: Check for cases where all electrodes are NaN at
%%%% given time point. If found, replace with column of zeros (until we
%%%% think of something better).
nanIndicator = isnan(xIn);
nanColSum = sum(nanIndicator, 1);
figure(100); plot(nanColSum, '*-');
xlabel('Time (samp)'); ylabel('Number of NaN electrodes');
title('Input to imputation: Number of NaNs per time sample')
xlim([0 length(nanColSum)]); ylim([0 nChannels])
badCols = find(nanColSum == nChannels);
badColReplaceVal = 0;
disp([num2str(length(badCols)) '/' num2str(length(nanColSum)) ' columns of all NaN found! Replacing with ' num2str(badColReplaceVal)])
xIn(:, badCols) = badColReplaceVal;

c = 1; % Initialize counter in case for some reason we can't impute all
cWarning = 6;
disp(['Number of NaNs: ' num2str(length(find(isnan(xIn)))) '.'])

xOut = xIn;
figCount = 500;

while length(find(isnan(xOut))) > 0
    
    if c > cWarning 
        warning(['Unable to impute all NaNs after ' num2str(cWarning) ' attempts.']);
        blah = isnan(xOut);
        blah2 = sum(blah, 1); 
%         figure(); imagesc(isnan(xOut)); colorbar;
        figure(figCount); plot(blah2, '*-'); figCount = figCount + 1;
    end
    
    disp(['Imputing data: Attempt ' num2str(c) '.'])
    
    for ch = 1:nChannels % Iterate through each electrode
        currNei = neighbors{ch}; % These specify the neighbors (rows)
        currNei = currNei(:); % Make it be a column (for consistency)
        currNaN = find(isnan(xIn(ch,:)));  % These specify the NaN time points (columns)      
        if showNeighbors, disp(['Electrode ' num2str(ch) ', neighbors ' mat2str(currNei')]); end
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
