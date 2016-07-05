function batchCellICA(matDir)

% batchCellICA(matDir)
% --------------------
% Blair - August 24, 2015
% Run cell ICA on all .mat files in the specified directory. The function
% reads in every .mat file in the given directory, then performs extended
% Infomax ICA on every matrix in the xRaw cell array in that file. A cell
% array W is written out in the W sub-directory, having the same name as
% the input .mat file.
%
% See also batchICA doICA doCellICA

% Make sure the directory is valid
if exist(matDir, 'dir')
    disp(['Directory ' matDir ' found.' ])
else
    error(['Directory ' matDir ' not found.'])
end

cd(matDir);

% Create the W directory if it doesn't exist
if ~ exist('W', 'dir')
    disp(['Creating W directory.'])
    mkdir W
end

% Get the list of .mat files in the directory
fileList = dir('*.mat');

for f = 1:numel(fileList)
    load(fileList(f).name)
    W = doCellICA(xRaw);
    %W = f; %%%% for testing
    cd W
    eval(['save ' fileList(f).name ' W'])
    cd ../
    clearvars -except fileList f
end