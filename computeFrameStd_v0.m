function [stds, WinXax] = computeFrameStd_v0(dataIn, fs, wLenSec, wShiftSec)
% [rhos, WinXax] = computeISCs_v0(dataIn, fs, doPerm, wLenSec, wShiftSec, 
% permWinSec, pIdx, nPermIter)
% ------------------------------------------------------------------------
% Blair - April 1, 2016
% Using ISC windows and computing per-subject standard deviation of behav
% data in that frame as a measure of activity over time.

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

nSubs = size(dataIn,2);

% Get window length and hop size in SAMPLES
wLenSamp = round(fs * wLenSec);
wShiftSamp = round(fs * wShiftSec);

% Get total number of samples in the trial
totalSamples = size(dataIn, 1);

% Construct the correlation windows
nCorrWins = floor((totalSamples-wLenSamp)/wShiftSamp + 1);
disp(['Number of subjects: ' num2str(nSubs)])
disp(['Song length in samples: ' num2str(totalSamples)])
disp(['Number of correlation windows: ' num2str(nCorrWins)])
corrWins = cell(nCorrWins,1);
for w = 1:nCorrWins-1
    corrWins{w,1} = (w-1)*wShiftSamp + (1:wLenSamp);
end
% Final window can be longer
corrWins{nCorrWins,1} = ((nCorrWins-1) * wShiftSamp + 1):totalSamples;

% Save min/mean/max time in seconds from each window as x-axis for
% plotting
WinXax.mean = cellfun(@mean, corrWins)/fs;
WinXax.max = cellfun(@max, corrWins)/fs;
WinXax.min = cellfun(@min, corrWins)/fs;


% Initialize the cell to store the ISC output
stds = nan(nCorrWins, nSubs);

tic
for i = 1:nCorrWins
    stds(i,:) = std(dataIn(corrWins{i},:));
end
toc