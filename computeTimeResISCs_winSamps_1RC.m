function [rhos, WinXax] = computeTimeResISCs_winSamps_1RC(dataIn, fs, wLenSamp, wShiftSamp, pIdx)
% [rhos, WinXax] = computeTimeResISCs_winSamps_1RC(dataIn, fs, wLenSamp, 
% wShiftSamp, pIdx)
% ------------------------------------------------------------------------
% Blair - August 15, 2017
% Adapted from Blair - May 9, 2017 computeISCs_intactOnly
% Adapted from Blair - April 1, 2016 computeISCs_v0
% This function computes time-resolved ISCs of the intact version of the
% input data frame. It outputs a vector of rhos and a struct of various
% x-axes.
% Inputs:
% - dataIn: T x trial input data matrix
% - fs: Sampling rate in Hz
% - wLenSamp: Correltion window length in SAMPLES
% - wShiftSamp: Correlation window hop size in SAMPLES
% - pIdx: nPairs x 2 matrix of trial combinations to look at
% Outputs:
% - rhos: T* nPairs matrix of time-resolved correlations
% - WinXax: Struct with 'mean', 'max', and 'min' fields - each of which is
%   a T* x 1 vector
% (T* indicates that time is in correlation windows, different from the
%   input T which was time samples of data.)

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

% Get total number of samples in the trial
totalSamples = size(dataIn, 1);

% Construct the correlation windows
nCorrWins = floor((totalSamples-wLenSamp)/wShiftSamp + 1);
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

disp('Original condition: One iteration only')

% Initialize the cell to store the ISC output
rhos = nan(nCorrWins, size(pIdx,1));

tic
theData = dataIn; % This is the original data - time x subjects
% Compute pairwise ISCs for every pair
for p = 1:size(pIdx,1)
    rhos(:,p) = compute_cc_fixed(theData(:,pIdx(p,1)), theData(:,pIdx(p,2)),corrWins);
end
toc