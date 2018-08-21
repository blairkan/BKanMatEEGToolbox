function structImputed = imputeAllTrialsInStruct125(structNaNs, doIter)
% ----------------------------------------------------------------------
% structImputed = imputeAllTrialsInStruct125(structNaNs, [doIter])
% Blair - April 8, 2017
% This function loads a 3d chan-x-time-x-trial song struct and imputes the
% NaNs in each trial by using a spatial average of neighbors. 
% Inputs
% - structNaNs: 3d data matrix, maybe with missing values
% - doIter: Optional argument whether to iteratively compute spatial
%   average even within the larger loop iteration.
%
% Outputs
% - structImputed: 3d data matrix, same size as structNaNs.

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2017 Blair Kaneshiro
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

[nChan, nTime, nTrial] = size(structNaNs);
structImputed = nan(size(structNaNs));
if nargin  < 2, doIter = 1; end

for t = 1:nTrial
    disp(['Imputing trial ' num2str(t) ' of ' num2str(nTrial)])
    currData = squeeze(structNaNs(:, :, t));
    % Impute missing values
    c = 1;
    xImputeTrial = currData;
    while length(find(isnan(xImputeTrial))) > 0
        disp(['Imputing NaNs; attempt ' num2str(c)])
        xImputeTrial = imputeAllNaN125(xImputeTrial, doIter);
        if c > 5
            disp(['Not converging!'])
            break
        end
        c = c + 1;
    end
    structImputed(:, :, t) = xImputeTrial;
    
end