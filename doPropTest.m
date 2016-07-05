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
% courses. Proportions are ps1, ps2; ISC lengths are both lenISC.
% > [p0, stat, p] = doPropTest(ps1, ps1, lenISC, lenISC);
%
% Output variables:
% - p0: Pooled estimate of proportion under H0
% - stat: The chi-squared statistic, computed by hand
% - p: The p-value

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

