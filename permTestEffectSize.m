function [d, permMean, permStd] = permTestEffectSize(mObs, mPerm, dispLen)
% [d, permMean, permStd] = permTestEffectSize(mObs, mPerm)
% ---------------------------------------------------------
% Blair - October 12, 2021
%
% This function computes effect size for an observed effect and related
% null distribution. For instance, for group-averaged ISC, it computes the
% number of (null) standard deviations between the observed result and the
% expected result under the null distribution:
%       d = (m_observed - m_null) / sd_null
%
% INPUTS (required)
% - mObs: The observed value, e.g., the group-averaged ISC using intact
%   data.
% - mPerm: The null distribution of mObs. For instance, a vector of 1,000
%   group-averaged ISC values computed using surrogate data.
%
% INPUTS (optional)
% - dispLen: Whether to print a message of the size of the null
%   distribution. If not entered or empty, will default to FALSE.
%
% OUTPUTS
% - d: The effect size, calcuated as (mObs - mean(mPerm)) / std(mPerm).
% - permMean: The expected value under the null distribution, mean(mPerm).
% - permStd: The standard deviation under the null distribution std(mPerm).

%% Process inputs

% Make sure user input two values
assert(nargin >= 2, ...
    'Two inputs are required: The observed value, and the null distribution of the observed value.')

% There should be no missing values in the null distribution
assert(~any(isnan(mPerm(:))), ...
    'Null distribution input should not contain missing values!')

% For now, the second input must be a vector (only one null distribution)
assert(isvector(mPerm), ...
    'Null distribution input must be a vector.')

if nargin < 3 || isempty(dispLen)
    dispLen = 0; end

% Print the size of the null distribution
if dispLen
    disp(['Calculating effect size over a null distribution of size ' num2str(length(mPerm))])
end

%% Calculate effect size

permMean = mean(mPerm);
permStd = std(mPerm);
d = (mObs - permMean) / permStd;