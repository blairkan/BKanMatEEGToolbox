function plotCandidateEOG257(x257)
% plotCandidateEOG257(x257)
% ------------------------------
% Blair - November 21, 2016
% This function takes in a channels x time data matrix (typically x129 or
% x129epoched) and plots the time courses of the candidate EOG channels.
% Candidate EOG channels are always [127 126 25 8 32 1 128 125]. The user
% is responsible for initiating and titling the figure.

% Adapted from plotCandidateEOG Blair - Feb. 29, 2016

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

% candidateEOG = [8 126 25 127 1 32 125 128];
candidateEOG = [54 1 37 18 244 234];

if size(x257,1) < 256
    error('Data frame must contain data from at least 128 electrodes.')
end

tt = {'HEOG L', 'HEOG R', 'VEOG LU', 'VEOG RU', 'VEOG LC', 'VEOG RC'}

for i = 1:length(candidateEOG)
   subplot(3, 2, i)
   plot(x257(candidateEOG(i),:)); grid on; 
   title(['Electrode ' num2str(candidateEOG(i)) ',' tt{i}], 'fontsize', 14)
   xlim([1 length(x257)])
end