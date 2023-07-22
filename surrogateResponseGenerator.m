function response=surrogateResponseGenerator(response)
% response=surrogateResponseGenerator(response)
% --------------------------------------------------------
% This function takes in a time x chan(comp) matrix and returns a
% phase-scrambled version of the data.
% From Jacek - April 3, 2017

% This software is licensed under the 3-Clause BSD License (New BSD License),
% as follows:
% -------------------------------------------------------------------------
% Copyright 2017 Jacek P. Dmochowski
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

T = size(response,1); % Time is the number of rows
nChannels = size(response,2); % nChannels is number of columns
disp([num2str(nChannels) ' Channels, ' num2str(T) ' Time Points'])
if mod(T,2)~=0 % if T is not even
    T = T-1; % Lessen by 1 sample
    zeroPad=1; % Do zero padding at the very end
else
    zeroPad=0; % We're even, don't need to rm a row or later zero pad
end

% Fourier transform of the original dataset
responseFFT = fft(response(1:T,:)); %fourier transform signal
amplitude = abs(responseFFT(1:T/2+1,:)); %compute frequency amplitude
phase = angle(responseFFT(1:T/2+1,:)); %compute phase
phaseRandomized = -pi + 2*pi * rand(T/2-1,1); % Generate random phase
responseRandomized(2:T/2,:) = amplitude(2:T/2,:) .* exp(sqrt(-1) * (phase(2:T/2,:) + repmat(phaseRandomized,1,nChannels))); % randomize the phase
response = ifft([responseFFT(1,:); responseRandomized(2:T/2,:); responseFFT(T/2+1,:); conj(responseRandomized(T/2:-1:2,:))]); % rearrange  freq

% Here, zero padding means we add a row of zeros at the end
if zeroPad
    %     response=[response;zeros(1,nChannels)]; % RM 2023-07-22
    
    % NEW 2023-07-22: Repeat final row (avoids large discontinuity)
    response = [response; response(end, :)];
end
