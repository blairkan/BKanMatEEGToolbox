function [p, h, s] = doMatrixSignrankGetStat(dataIn, tail)
% [p, h, s] = doMatrixSignRank(dataIn, tail)
% --------------------------------------------
% Blair - April 4, 2016
% This function takes in a time x subs matrix of data and performs the
% Wilcoxon signed rank test on every row of data (that is, across all
% subjects for a given time point). A vector of p values is returned.
%
% The 'tail' argument is optional. If no tail is supplied, the test will do
% two tailed. If a tail is supplied, you will get a message printed to the
% console.
%
% Outputs: 
% p is the vector of p-values
% h is the returns on the tests
% s is an array struct with the test statistics

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

if nargin < 2
    disp(['No tail provided. Using two-tailed test.'])
    theTail = 'both';
else
    switch tail
        case {'right', 'r', 'pos'}
            disp('Right tail specified.')
            theTail = 'right';
        case {'left', 'l', 'neg'}
            disp('Left tail specified.')
            theTail = 'left';
        case {'both', 'center', 'two', 'b', 'm'}
            disp('Both tails specified.')
            theTail = 'both';
        otherwise 
            error('Unexpected tail! Exiting.')
    end
end

nObs = size(dataIn,1);
nSubs = size(dataIn,2);

disp(['Performing Wilcoxon signed rank tests:'])
disp([num2str(nObs) ' observations (rows)'])
disp([num2str(nSubs) ' data points per observation (columns)'])

p = nan(nObs,1);
h = nan(nObs,1);

for i = 1:nObs
    [p(i), h(i), s(i)] = signrank(dataIn(i,:), 0, 'tail', theTail);
end