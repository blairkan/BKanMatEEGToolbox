function [corrV, corrH, aboveThreshold] = corrEOG(data, VEOG, HEOG, thresh)

% [corrV, corrH, aboveThreshold] = corrEOG(data, VEOG, HEOG, thresh)
% -----------------------------------------------------
% Blair - May 7, 2014
% Compute and plot the correlations of each ICA source signal with the VEOG
% and HEOG channels. Display in the console window the sources whose
% correlation magnitude is greater than or equal to the threshold.
%
% Inputs
%   - Data frame (EEG in ICA space, each channel is a COLUMN)
%   - VEOG data channel
%   - HEOG data channel
%   - [optional] Correlation threshold
% If no fourth argument is supplied, the function uses a default threshold
% of 0.3
%
% Outputs
%   - Vector of VEOG correlation coefficients
%   - Vector of HEOG correlation coefficients
%   - Vector of source numbers exceeding correlation threshold

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2014 Blair Kaneshiro
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

if nargin == 3
    thresh = 0.3;
end

% Make sure the data matrix passed in has more rows than columns
if size(data,1) < size(data,2)
    disp('Transposing the data matrix');
    data = data.';
end

HEOG = HEOG(:);
VEOG = VEOG(:);

corrH = corr(data, HEOG);
corrV = corr(data, VEOG);

aboveThreshold = find(abs(corrH) >= thresh | abs(corrV) >= thresh);