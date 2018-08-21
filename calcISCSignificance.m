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