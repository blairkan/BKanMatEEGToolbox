function [F, fIdx] = createFreqDomainFilter(N, fs, hiLowThreshes, filterType)
% [F, fIdx] = createFreqDomainFilter(N, fs, hiLowThreshes, [filterType])
% ----------------------------------------------------------------
% Blair - July 18, 2016
%
% This function creates a frequency-domain filter.
%
% Inputs:
% - N: Length of input data. Must be positive and an integer. If N is not
% even, this function will truncate by one sample so that the filter has an
% even number of samples.
% - fs: Sampling rate of the data.
% - hiLowThreshes: 2-element vector. The first element specifies the hipass
% cutoff, and the second element specifies the lowpass cutoff. Thus,
% frequencies strictly less than the highpass cutoff will be omitted, as
% will frequencies strictly greater than the lowpass cutoff. 
%
% Outputs:
% - F: Column vector containing the frequency-domain filter. F is of length
% N (or N-1, if N was odd to begin with). The filter always contains the
% following elements: 
%  F(1) = Zero-valued DC component
%  F(2:N/2) = N/2-1 elements corresponding to positive frequencies; 
%  F(N/2 + 1) = zero-valued Nyquist component;
%  F((N/2+2):end) = N/2 - 1 elements corresponding to negative frequencies.
%  the negative frequencies are the flipped vector of the positive
%  frequencies.
% - fIdx: The vector of frequencies corresponding to the elements in F.

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

%%%%%% SOME INPUT CHECKING %%%%%%%
% Need to make sure N is a positive, even integer
if (N <= 0) | (rem(N, 1) ~= 0)
    error('N must be a positive integer.')
elseif (rem(N, 2) ~= 0)
    disp(['N is odd. Truncating by one sample so N is even.'])
    N = N-1;
    disp(['New N = ' num2str(N)])
end

% Function currently requires vector of highpass, lowpass cutoffs
if length(hiLowThreshes) ~= 2
    error(['Thresholds parameter must contain exactly two values.'])
elseif hiLowThreshes(1) == hiLowThreshes(2)
    error('Hi and low frequency thresholds must be different values.')
elseif hiLowThreshes(1) > hiLowThreshes(2)
    warning('Frequency thresholds are out of order. Reversing frequency ordering.')
    hiLowThreshes = sort(hiLowThreshes);
    disp(['Thresholds are now ' mat2str(hiLowThreshes)])
end

% There's an optional argument to make it a bandstop rather than bandpass
% filter. If argument is not supplied, we assume bandpass.
if nargin < 4
    disp('Assuming bandpass filter.')
    filterType = 'pass';
elseif ismember(filterType, {'bandpass', 'pass', 'bp', 'p'})
    disp('Implementing bandpass filter.')
    filterType = 'pass';
elseif ismember(filterType, {'bandstop', 'stop', 'bs', 's'})
    disp('Implementing bandstop filter.')
    filterType = 'stop';
else
    error('Filter type not recognized.')
end
%%
% Initialize the frequency index that we'll use for assessing frequencies
% for the filter. To start, we will consider only the positive frequencies.
% Once the positive-frequency filter is created, we will flip it to create
% the negative-frequency filter. Note that the length is two samples too 
% long due to the inclusion of the zero and Nyquist frequencies, which are
% then removed.

fIdx = linspace(0, fs, N+1); % This is the full frequency axis (extra element) 
fIdx = fIdx(1:(end-1)); % Rm last sample so it's length N
fIdx = fIdx(:); % Make it a column

% Verify that the 0 and Nyquist freqs are in the right place
if fIdx(1) ~= 0
    error('First element of frequency vector is not 0 Hz.')
elseif fIdx(N/2 + 1) ~= fs/2
    error('Element N/2 + 1 of frequency vector is not Nyquist frequency.')
else
    disp('DC and Nyquist frequencies correctly indexed.')
end

posFreqs = fIdx(2:(N/2)); % Get positive frequencies only

% Initialize the filter - currently all 1's
posFilter = ones(size(posFreqs));

% Highpass filter: Frequencies (strictly) lower than the specified cutoff
% are set to zero.
posFilter(posFreqs < hiLowThreshes(1)) = 0;

% Lowpass filter: Frequencies (strictly) greater than the specified cutoff
% are set to zero.
posFilter(posFreqs > hiLowThreshes(2)) = 0;

% Now that the positive-frequency filter is complete, let's combine with
% other elements for the full filter.
F = [0; 
    posFilter; 
    0;
    flip(posFilter)];

if strmatch(filterType, 'stop')
    F = 1-F;
    disp('Bandpass filter converted to bandstop filter.')
end
