function [allCohere, fAx] = computePairwiseCrossSpectrum_1comp(dataIn, pIdx, wLenSamp, fs, noverlap, nfft)
% [allCohere, fAx] = computePairwiseCoherence_1comp(...
%               dataIn, pIdx, wLenSamp, fs, [noverlap], [nfft])
% --------------------------------------------------------------------
% Blair - Jan 19, 2018
%
% This function computes pairwise cross spectrum among specified pairs of
% columns of the input data matrix. 
%
% Inputs:
% - dataIn: time x trial data matrix
% - pIdx: nPairs x 2 matrix of trial number pairs
% - wLenSamp: Window length, in samples (must be an integer)
% - fs: Sampling rate, in Hz
% - [noverlap]: Number of samples of overlap between adjacent windows
% - [nfft]: Number of samples in FFT computation
%
% Outputs
% - cxy: frequency x pair matrix of coherences
% - fAx: Frequency axis, for plotting

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

% if nargin < 4, error('Required inputs: dataIn, pIdx, wLenSamp, fs'); end
% if nargin < 5, noverlap = []; end % Use default 50% overlap
% if nargin < 6, nfft = []; end % Use default nfft = max(256, 2^(log2(N)))

%%%%%%% Dev - comment out if running as function %%%%%%
% ccc
% cd('/usr/ccrma/media/jordan/Experiments/Tempo2/SongStructs_ICA_Imputed_SDR')
% load song30_Imputed.mat
% [dataRCA, W, A, Rxx, Ryy, Rxy, dGen] = rcaRun125(permute(data30, [2 1 3]), 7, 5);
% 
% dataIn = squeeze(dataRCA(:, 1, :)); % T x trial
% 
% % DC Correct
% dataIn = dataIn - repmat(mean(dataIn, 1), size(dataIn, 1), 1);
% 
% dataIn = dataIn(1:(60*fs), :);
% 
% pIdx = getPIdx(size(dataIn, 2));
% fs = 125;
% wLenSamp = 5 * fs; 
% noverlap = [];
% nfft = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

if nargin < 6, nfft = []; end
if nargin < 5, noverlap = []; end

% - dataIn is a matrix of size time x nTrials
% - pIdx is a matrix of size nPairs x 2
% - allCohere will be a matrix of size freqs x nPairs
close all
for p = 1:size(pIdx,1)
    currPair = pIdx(p,:);
    disp(['Current pair: ' mat2str(currPair)])
    [temp, fAx] = cpsd(...
        dataIn(:, currPair(1)), dataIn(:, currPair(2)),...
        wLenSamp, noverlap, nfft, fs);
    if p == 1
        disp('**Initializing cross spectrum function output matrix**');
        allCohere = nan(length(temp), size(pIdx, 1));
    end
    allCohere(:, p) = temp;
        
end

% plot(fAx, mean(allCohere, 2), 'k', 'linewidth', 2); xlim([0 10])