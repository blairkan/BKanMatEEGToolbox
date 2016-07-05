function Behav = getBehavResults(triggers, nTrials, header)

% Behav = getBehavResults(triggers, nTrials, header)
% --------------------------------------------------------
% Blair
% August 24, 2015
%
% This function takes in the vector of participant rankings (with optional
% stimulus labels) and reshapes into a question x trial matrix, with added 
% header row with trial numbers if specified. 
%
% Inputs
%   - triggers: Array of ratings with optional stimulus labels
%   - nQuestions: How many questions were asked per stimulus
%   - header: Enter 1 if stimulus labels included (and will serve as row
%   headers). Default = 1
%
% The output struct has two fields: One is a matrix
% of the absolute ratings, and the other is a matrix of ranked ratings,
% where rankings are performed one question at a time, across all stimuli.

if nargin == 2
   disp('Function note: Assuming header row')
end

if header == 0
    iStart = 1;
else
    iStart = 2;
end

triggers = triggers(:)'; % Make sure it's a row vector
Behav.abs = reshape(triggers, [], nTrials);
Behav.rank = Behav.abs;
for i = iStart:size(Behav.rank,1)
   Behav.rank(i,:) = tiedrank(Behav.rank(i,:)); 
end


