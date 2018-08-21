function h = doFDR(pvals, q)
% h = doFDR(pvals, q)
% ---------------------------------------------------
% From Jacek - April 22, 2016 (was fdr.m)
% This script takes in a vector of p-values from multiple significance
% tests and a desired FDR level (analogous to alpha; optional), and outputs
% an array the same size as the input indicating the corrected hypothesis
% test results.
%
% Inputs
% - pvals: p-values of your multiple significance tests
% - q: Desired FDR level (like alpha) -- defaults to 0.05
%
% Output
% - h: Array of size(pvals) indicating the corrected hypothesis test 
% results: 1 indicates a rejected null hypothesis
% 
% Reference: Benjamini, Yoav; Yekutieli, Daniel (2001). "The control of 
% the false discovery rate in multiple testing under dependency". Annals 
% of Statistics 29 (4): 1165�1188.

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2016 Jacek P. Dmochowski
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

sz=size(pvals); pvals=pvals(:);  m=length(pvals);

if nargin<2 
    disp('No desired FDR level specified. Defaulting to 0.05.')
    q=0.05; 
end

[c,d]=sort(pvals,'ascend');
mxind=max(find( (c<=(1:m)'/m*q) ));
h=zeros(size(pvals));
h(d(1:mxind))=1;  
h=reshape(h,sz(1),sz(2));


