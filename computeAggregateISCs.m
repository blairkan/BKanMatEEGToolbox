function [rhos, pIdx] = computeAggregateISCs(dataIn, rcUse)
% [rhos, pIdx] = computeAggregateISCs(dataIn, rcUse)
% --------------------------------------------------
% Blair - December 1, 2016
% Compute ISCs across all time of the data. No sliding temporal window or
% permutation iterations (so no % significant ISC).
%
% Inputs:
% - dataIn: 3D time x RC x trial
% - rcUse: Which RC to use for ISCs (typically a number from 1:5)
% Outputs:
% - rhos: nPairs x 1 vector of pairwise correlation coefficients
% - pIdx: nPairs x 2 matrix of all trial/subject pair labels

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

% % For dev/testing
% inDir = '/usr/ccrma/media/jordan/Experiments/ImClRCA/RCAOut';
% fnIn = 'rcaOut_cat_6_sub_6_20161201.mat';
% cd(inDir)
% load(fnIn)
% rcUse = 1;
% dataIn = dataOut;

% Function stuff starts here
nTrials = size(dataIn, 3);
pIdx = getPIdx(nTrials);
dataUse = squeeze(dataIn(:, rcUse, :)); % time x trial/subject
disp(['Computing ISCs across all time for ' num2str(nTrials) 'trials.'])
rhos=[];
tic
for p = 1:size(pIdx, 1)
    rhos(p) = compute_cc_fixed(dataUse(:,pIdx(p,1)), dataUse(:,pIdx(p,2)),{1:size(dataUse,1)});
end
toc