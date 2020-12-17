function structImputed = imputeAllTrialsInStruct129(structNaNs, showNeighbors, doIter)
% --------------------------------------------------------------------------
% structImputed = imputeAllTrialsInStruct129(structNaNs, showNeighbors, doIter)
% Blair - December 2020 
%
% Adapted from structImputed = imputeAllTrialsInStruct125(structNaNs, [doIter])
% Blair - April 8, 2017
%
% This function loads a 3d chan-x-time-x-trial song struct and imputes the
% NaNs in each trial by using a spatial average of neighbors. 
% Inputs
% - structNaNs: 3d data matrix, maybe with missing values
% - showNeighbors: Whether to print the neighbors of each electrode in the
%   console (mainly for debugging). If not specified, the function will
%   print a warning and set to false.
% - doIter: Optional argument whether to iteratively compute spatial
%   average even within the larger loop iteration. If not specified, the
%   function will print a warning and set to true. 
%
% Outputs
% - structImputed: 3d data matrix, same size as structNaNs.

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2020 Blair Kaneshiro
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

%%% Check for missing inputs and return error or assign accordingly %%%
assert(nargin >= 1, 'Function requires at least one input.')
if nargin < 2 || isempty(showNeighbors)
    warning('Input ''showNeighbors'' not specified. Setting to false.');
    showNeighbors = 0;
end

if nargin  < 3 || isempty(doIter)
    warning('Input ''doIter'' not specified. Setting to true.');
    doIter = 1; 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[nChan, nTime, nTrial] = size(structNaNs);

% Initialize the output
structImputed = nan(size(structNaNs));

for t = 1:nTrial
    disp(['Imputing trial ' num2str(t) ' of ' num2str(nTrial)])
    currData = squeeze(structNaNs(:, :, t));
    
    % Impute missing values and assign to output
    structImputed(:, :, t) = imputeAllNaN129(currData, showNeighbors, doIter);
    
end