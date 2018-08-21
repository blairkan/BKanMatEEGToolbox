function [b, a] = createMultipeakIirpeak(freqs, widths, fs)
% ---------------------------------------------------------
% [b, a] = createMultipeakIirpeak(freqs, widths, fs)
% Blair - Jan 25, 2017
%
% This function creates a filter with multiple peaks at the speficied
% frequencies, with specified width(s).
% Inputs
% - freqs: Vector of frequencies, in Hz.
% - widths: Scalar or vector of peak widths, in Hz. If scalar, same width
%   will be applied to all frequencies. If a vector, each frequency will
%   have a different width (vector must be same length as freqs vector).
% - fs: Sampling rate of the data, in Hz.
% Outputs
% - b: Numerator filter coefficient of the combined filter.
% - a: Denominator filter coefficient of the combined filter.

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

% Ensure that 'widths' is an appropriate size
if (length(widths) > 1 & length(widths) ~= length(freqs))
    error('Variable ''widths'' must be a scalar or a vector of length length(freqs).')
end

% Make sure we are dealing with at least 2 filters
nFilters = length(freqs);
if nFilters < 2
    error('Function is intended for 2 or more filters.')
end

% Basic check on number of inputs
if nargin < 3
    error('Function requires three input arguments.')
end

% If widths was a scalar, make it a vector
if length(widths) == 1
    widths = widths * ones(size(freqs))
end

% For debugging
disp(['(debug) Freqs: ' mat2str(freqs)]); disp(['(debug) Widths: ' mat2str(widths)]);

for i = 1:length(freqs)
    [B{i}, A{i}] = iirpeak(freqs(i) / (fs/2), widths(i) / (fs/2));
end

[b, a] = combineFilters(B{1}, A{1}, B{2}, A{2});

if nFilters > 2
    for i = 3:nFilters
        [b, a] = combineFilters(b, a, B{i}, A{i});
    end
end


