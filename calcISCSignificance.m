function [q, propSig] = calcISCSignificance(origData, permData, sigAlpha)
% [q, propSig] = calcISCSignificance(origData, permData, sigAlpha)
% -----------------------------------------------------------------------
% Blair - April 4, 2016
%
% This function takes in ISC output and calculates what proportion of the
% intact ISCs are significant, according to the specified quantile of the
% permutation iterations.
%
% Inputs:
% - origData: nCorrelations x nPairs matrix
% - permData: nCorrelations x nPairs x nPermIter matrix
% - sigAlpha: Alpha level for significance (will default to 0.05 if not
% provided).
%
% Outputs
% - q: nCorrelations x 1 vector of the 1-sigAlpha quantiles for every
% correlation
% - propSig: The proportion of values in mean(origData) that are
% statistically sigificant given sigAlpha.

if nargin<3
    disp('No alpha provided. Setting alpha to 0.05')
    sigAlpha = 0.05;
end

if sigAlpha > 0.5
    disp(['sigAlpha is very high (' num2str(sigAlpha)...
        '). Setting to 1-sigAlpha = ' num2str(1-sigAlpha)])
    sigAlpha = 1-sigAlpha;
end

if (length(find(isnan(origData))) > 0 | length(find(isnan(permData))) > 0)
    warning(['Data contains nans. Using nanmean.'])
    permMean = squeeze(nanmean(permData,2));
    origMean = nanmean(origData,2);
else
    permMean = squeeze(mean(permData,2));
    origMean = mean(origData,2); 
end
q = quantile(permMean', 1-sigAlpha)';
propSig = length(find(origMean > q))/ length(q);