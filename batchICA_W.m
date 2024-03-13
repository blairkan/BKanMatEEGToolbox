function batchICA_W(inDir)
% batchICA_W(inDir)
% --------------------
% Blair - March 13, 2024
%
% This function runs ICA on all .mat files in the specified directory and
% saves the resulting W matrices: 
% - Gets list of input filenames in the specified directory, excluding
%   filenames that already end in '_W' (since those are presumably output 
%   files). 
% - For every input .mat file, load the file, compute ICA using the 'xRaw' 
%   variable, and save the resulting W matrix in an output file. The output
%   file has the same name as the input file, with '_W' appended to the end
%   of the filename.
%
% This function is similar to batchICA but not the same. Main changes:
% - References files via full path specification rather than cd-ing in.
% - Saves output files in same directory; does not create 'W' subdirectory.
% - Output filenames (containing only 'W' matrix) have '_W' appended to the
%   end rather than being identical to the input filenames.
%
% Input (required):
% - inDir: Path to directory containing RawMatEpoched files ready for ICA.
%
% See also batchICA batchCellICA doICA doCellICA

% Script history
% - 3/13/2024: Adapted from batchICA (5/9/2014)

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

%% Validate inputs

assert(nargin == 1, 'This function requires one input, the path to the directory of .mat files awaiting ICA.')

% Make sure the directory is valid
if exist(inDir, 'dir')
    disp(['Directory ' inDir ' found.'])
else
    error(['Directory ' inDir ' not found.'])
end

%% File indexing

% Get the list of .mat files in the directory
fList = dir([inDir filesep '*.mat']);

% Get initial list of filenames
fNames0 = {fList.name};

% Initialize final list of filenames
fNames = {};

% Iterate through the list of filenames and retain only those that don't
% (1) begin with '._' or (2) end with '_W.mat'.
for i = 1:length(fNames0)
    
    currFName = fNames0{i};

    if ~strcmp(currFName(1:2), '._') && ...
            ~strcmp(currFName(end-5:end), '_W.mat')
        fNames{end+1} = currFName;
    end

end

nFiles = length(fNames);

disp([newline 'Found ' num2str(nFiles) ' files:'])
fprintf('%s \n', fNames{:});

%% Do the stuff
for i = 1:nFiles

    % Get current input filename
    thisFnIn = fNames{i};
    
    % Print a message
    disp([newline '~*~*~ Processing file ' num2str(i) ' of ' num2str(nFiles) ...
        ': ' thisFnIn ' ~*~*~'])
    
    % Load the xRaw variable in the current file
    load([inDir filesep thisFnIn], 'xRaw');

    % Call doICA function on the xRaw variable
    % W = doICA(xRaw);
    W = i;

    % Save W to an output .mat file
    thisFnOut = [thisFnIn(1:end-4) '_W.mat'];
    save([inDir filesep thisFnOut], 'W')
    
    % Clear variables
    clear this* xRaw W

end