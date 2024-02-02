function [fNames, fList] = indexISCFilenames(inDir, fInitStr, searchStr)
% [fNames, fList] = indexISCFilenames(inDir, fInitStr, searchStr)
% -----------------------------------------------------------------
% Blair - Feb 1, 2024
%
% This function takes in various directory and filename specifications and
% returns a list of filenames, if any, in the directory matching the
% filename specifications. The function will ensure that only unique
% entries in the overall indexed list are returned.
%
% Inputs
% - inDir: Path to directory to be indexed
% - fInitStr: String with e.g., experiment/group and/or participant
%   identifier that starts off the filename.
% - searchStr: Other strings by which to index, e.g., block number,
%   stimulus condition label.
%
% Outputs
% - fNames: The list of unique filenames, as a cell array of strings. If
%   filenames are repeated, the subset unique list will be in alphabetical
%   order. It is up to the user to check the ordering of output filenames.
% - fList: The full 'dir' output, as a struct array. fList may have more
%   elements than fNames if any files were returned twice during indexing.

assert(nargin == 3, ['This function requires 3 inputs: The path to '...
    'the file directory, a string init identifier, and a variable string '...
    'identifier.'])

% How many searches are we doing?
nSearchStr = max(length(searchStr), 1);

% Init fList
fList = [];

% Index the files
for i = 1:nSearchStr

    fl = dir([inDir filesep fInitStr '*' searchStr{i} '*.mat']);

    fList = cat(1, fList, fl);

end

% Pull out fName
fNames = {fList.name};   % Here are all the names
fNames = fNames(:);       % Make it column orientation

if length(fNames) > length(unique(fNames))
    warning('Repeated filenames found! Returning unique subset.')
    fNames = unique(fNames);  % Return unique entries only (alphabetical)
end