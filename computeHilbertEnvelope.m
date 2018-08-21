function Env = computeHilbertEnvelope(xIn, fsIn, varargin)
% Env = computeHilbertEnvelope(xIn, fsIn, varargin)
% ---------------------------------------------------
% Blair - June 6, 2018
%
% This function takes in a vector variable and computes the amplitude
% envelope. There are options to resample and center/z-score the output.
%
% Required inputs:
% - xIn: Input vector (row or column)
% - fsIn: Input sampling rate
%
% Optional name-value pairs:
% - 'resample': fsOut -- numeric desired output sampling rate
% - 'centering': 'none' (default), 'zscore', 'mean'
%
% Outputs:
% - Env: A struct with the following fields
%   - fs: Sampling rate of the output envelope
%   - timeAx: Time sample indices (always a column)
%   - env: The envelope (same length as timeAx; always a column)
%   - centering: Which centering procedure was used

% Apated from Jacek generateEnvelope.m June 4, 2018.

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2018 Blair Kaneshiro and Jacek P. Dmochowski
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

% Initialize the input parser
ip = inputParser;
ip.CaseSensitive = false;
ip.KeepUnmatched = true;

% Specify default values
defaultResample = 0;
defaultCentering = 'none';

% Specify expected values
resampleError = 'Resampling parameter must be a postive number.';
validateResample = @(x) assert(isnumeric(x) && isscalar(x) ...
    && (x>=0), resampleError);
expectedCentering = {'none', 'zscore', 'mean'};

% Required inputs
addRequired(ip, 'xIn', @isvector)
addRequired(ip, 'fsIn', @isscalar)

% Optional name-value pairs
% NOTE: Should use addParameter for R2013b and later.
if verLessThan('matlab', '8.2')
    disp('Matlab version less than 8.2')
    addParamValue(ip, 'resample', defaultResample,...
        validateResample);
    addParamValue(ip, 'centering', defaultCentering,...
        @(x) any(validatestring(x, expectedCentering)));
else
%     disp('Matlab version is R2013b or later.')
    addParameter(ip, 'centering', defaultCentering,...
        @(x) any(validatestring(x, expectedCentering)));
    addParameter(ip, 'resample', defaultResample,...
        validateResample);
    
end

% Parse and extract parsed results
parse(ip, xIn, fsIn, varargin{:});
fsOut = ip.Results.resample;
centeringMethod = expectedCentering{contains(expectedCentering,ip.Results.centering)};

% Dev
% disp(['xIn: ' mat2str(xIn)])
% disp(['Input fs: ' num2str(fsIn)])
% disp(['Output fs: ' num2str(fsOut)])
% disp(['Centering method: ' centeringMethod])

% Compute the envelope
xIn = xIn(:);
xH = abs(hilbert(xIn));
if fsOut == 0
    fsOut = fsIn; % Reset output fs and don't resample
else
    xH = resample(xH, fsOut, fsIn); % Resample
end

switch centeringMethod
    case 'mean'
        xH = xH - mean(xH);
    case 'zscore'
        xH = zscore(xH);
    otherwise
end

Env.fs = fsOut;
Env.env = xH;
Env.centering = centeringMethod;
Env.timeAx = (0:(length(xH)-1))/fsOut;
