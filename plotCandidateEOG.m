function plotCandidateEOG(x129)
% plotCandidateEOG(x129)
% ------------------------------
% Blair - Feb. 29, 2016
% This function takes in a channels x time data matrix (typically x129 or
% x129epoched) and plots the time courses of the candidate EOG channels.
% Candidate EOG channels are always [127 126 25 8 32 1 128 125]. The user
% is responsible for initiating and titling the figure.

% candidateEOG = [8 126 25 127 1 32 125 128];
candidateEOG = [127 126 25 8 32 1 128 125];

if size(x129,1) < 128
    error('Data frame must contain data from at least 128 electrodes.')
end

for i = 1:length(candidateEOG)
   subplot(4, 2, i)
   plot(x129(candidateEOG(i),:)); grid on; 
   title(['Electrode ' num2str(candidateEOG(i))], 'fontsize', 14)
   xlim([1 length(x129)])
end