function [xOut, randVals] = addUniformNoiseToMatrix(xIn, noiseParam)
% [xOut, randVals] = addUniformNoiseToMatrix(xIn, noiseParam)
% ------------------------------------------------------------------
% Blair Kaneshiro - Feb 2021
%
% This function takes in a matrix of any size and adds noise to each
%   element. This can be useful e.g., in cases where we need to compute ISC
%   over data with zero variance.
%
% INPUTS
% - xIn (required): Input data matrix
% - noiseParam (optional): Scalar noise parameter. If entered, random noise
%   that is uniform over the open interval (-noiseParam, noiseParam) will
%   be added to each element of the input data matrix xIn. 
%   - Must be a positive value; if not positive, function will return an
%       error.
%   - If empty or not specified, the function will print a warning and set 
%   this value to 0.001 as default.
%
% OUTPUTS
% - xOut: Data matrix (same size as xIn) with noise added to each element.
% - randVals: Data matrix (same size as xIn) with just the noise values.
%   That is, xOut = xIn + randVals.
%
% See also rand

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2021 Blair Kaneshiro
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

if nargin < 1 || isempty(xIn)
    error('Function requires at least one input.')
end

if nargin < 2 || isempty(noiseParam)
    warning('Input ''noiseParam'' not entered. Setting this value to 0.001');
    noiseParam = 0.001;
end

assert(noiseParam > 0,...
    'Input ''noiseParam'' must be greater than zero.');
% keyboard

% Rand is uniform over (0, 1). We make uniform over (0, 2*noiseParam) and
%   then subtract noiseParam to center it.
randVals = rand(size(xIn)) * 2 * noiseParam - noiseParam;

xOut = xIn + randVals;