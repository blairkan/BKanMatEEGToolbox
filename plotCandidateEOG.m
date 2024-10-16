function plotCandidateEOG(x129, includeCheek)
% plotCandidateEOG(x129, includeCheek)
% --------------------------------------------
% Blair - Feb. 29, 2016
% This function takes in a channels x time data matrix (typically x129 or
% x129epoched) and plots the time courses of the candidate EOG channels.
% Candidate EOG channels are always [127 126 25 8 32 1 128 125]. 
% - The user is responsible for initiating and titling the figure. 
% - The function will work with 128-channel input matrix as well, but will
%   return an error if fewer than 128 channels (rows) are present.
%
% Inputs
% - x129 (required): Channels x time data matrix
% - includeCheek (optional): Boolean of whether to plot the cheek
%   electrodes (126 and 127). The user may want to exclude these e.g., if
%   they will never be considered for VEOG due to participants wearing
%   masks. If empty or not entered, will default to true. 

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

candidateEOG = [127 126 25 8 32 1 128 125];
eogDescription = {'L cheek', 'R cheek', 'L VEOG', 'R VEOG',...
    'L HEOG1', 'R HEOG1', 'L HEOG2', 'R HEOG2'};
nSubplotRows = 4; 

if nargin < 2 || isempty(includeCheek)
    includeCheek = 1; 
end

if ~includeCheek
    candidateEOG = candidateEOG(3:end);
    eogDescription = eogDescription(3:end);
    nSubplotRows = 3; 
end

if size(x129,1) < 128
    error('Data frame must contain data from at least 128 electrodes.')
end

for i = 1:length(candidateEOG)
   subplot(nSubplotRows, 2, i)
   plot(x129(candidateEOG(i),:)); grid on; 
   title(['Ch ' num2str(candidateEOG(i)) ' (' eogDescription{i} ')'], 'fontsize', 12)
   xlim([1 length(x129)])
end