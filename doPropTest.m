function [p0, stat, p] = doPropTest(propSig1, propSig2, nObs1, nObs2)
% [p0, stat, p] = doPropTest(propSig1, propSig2, nObs1, nObs2)
% ---------------------------------------------------------------------
% Blair - April 5, 2016
% 
% This function takes in two proportions and their respective sample sizes,
% and determines whether the difference of proportions is statistically
% significant using a chi-squared test. 
% Reference: http://bit.ly/1WaoGU7 (Mathworks)
%
% Example usage: Compare proportions of significant ISCs for two ISC time
% courses. 
% > [p0, stat, p] = doPropTest(ps1, ps2, nObs1, nObs2);
%
% Input variables:
% - Proportions are ps1, ps2 (values less than or equal to 1)
% - ISC lengths are number of time windows for analysis
%
% Output variables:
% - p0: Pooled estimate of proportion under H0
% - stat: The chi-squared statistic, computed by hand
% - p: The p-value

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

if (propSig1 > 1 | propSig2 > 1)
    error('Proportion must be a value less than or equal to 1.')
end

% Convert proportions of successes to number of successes
n1 = round(propSig1 * nObs1);
n2 = round(propSig2 * nObs2);

% Pooled estimate of proportion
p0 = (n1 + n2) / (nObs1 + nObs2);

% Expected counts under H0
n1_0 = nObs1 * p0;
n2_0 = nObs2 * p0;

% Observed successes and failures
observed = [n1 nObs1-n1 n2 nObs2-n2];
% Expected successes and failures under H0
expected = [n1_0 nObs1-n1_0 n2_0 nObs2-n2_0];

% Chi-square test by hand
stat = sum((observed - expected).^2 ./ expected);

% Get the p-value
p = 1 - chi2cdf(stat, 1);

