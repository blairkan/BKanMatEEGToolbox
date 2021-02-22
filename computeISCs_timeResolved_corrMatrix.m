function [rhos, WinXax] = computeISCs_timeResolved_corrMatrix(dataIn, fs, wLenSamp, wShiftSamp)
% [rhos, WinXax] = computeISCs_timeResolved_corrMatrix(dataIn, fs, wLenSamp, wShiftSamp)
% ------------------------------------------------------------------------
% Blair - Feb 21, 2021
%
% This function computes a one-against-all ISC correlation matrix across
% specified time windows.
%
% INPUTS
% - dataIn: Input data matrix (time x trial)
% - fs: Sampling rate (for computing W times in sec)
% - wLenSamp: ISC window length, in time samples
% - wShiftSamp: ISC window shift, in time samples
%
% OUTPUTS
% - rhos: 3D matrix of ISC outputs (window x trial x trial)
% - WinXaX: Struct with fields 'mean', 'min', 'max' fields (windox x 1),
%   designating window time in seconds, for plotting results.
%
% Adapted from computeISCs_intactOnly_winSamps Blair - August 15, 2017
% Adapted from Blair - May 9, 2017 computeISCs_intactOnly
% Adapted from Blair - April 1, 2016 computeISCs_v0

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2021 Blair Kaneshiro
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

% Get (1) number of time samples per trial, (2) number of trials
[totalSamples, nTrials] = size(dataIn); % Input matrix is time x trial

% How many correlation windows do we need?
nCorrWins = floor((totalSamples-wLenSamp)/wShiftSamp + 1);
disp(['Song length in samples: ' num2str(totalSamples)])
disp(['Number of correlation windows: ' num2str(nCorrWins)])

% Construct the correlation windows
% Each element of cell array corrWins is the index of time samples for the
% current window. E.g., for 5-sec win, 1-sec shift, fs=125
% - corrWins{1} = 1:625
% - corrWins{2} = 126:750
corrWins = cell(nCorrWins,1);
for w = 1:nCorrWins-1 % Fill in all but the last window
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
rhos = nan(nCorrWins, nTrials, nTrials);


% Iterate through the time windows and compute correlation matrix for each
% time window
tic
for i = 1:nCorrWins
   currTimeSamples = corrWins{i};
   currData = dataIn(currTimeSamples, :); % window time x trial matrix
   rhos(i, :, :) = computeISCMatrix(currData);
   
   clear curr*
end
toc

assert(sum(isnan(rhos(:))) / nTrials == nCorrWins,...
    'Time-resolved ISC output does not have expected number of NaNs.')