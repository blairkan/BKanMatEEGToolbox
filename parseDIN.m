function [allTriggers, allOnsets] = parseDIN(din)

% [allTriggers, allOnsets] = parseDIN(DIN_1)
% -------------------------------------
% Blair - May 6, 2014
% Takes in the DIN_1 variable and returns two vectors. First vector is all
% trigger labels (as integers); second vector is all onsets at the original
% sampling rate (usually 1 kHz).

% Get all the triggers from the first row of DIN
allTriggers = str2double(regexprep(regexprep(regexprep(din(1,:),...
    'D', ''), 'I', ''), 'N', '')); 

% Get all onsets from second row of DIN
allOnsets = cell2mat(din(2,:));