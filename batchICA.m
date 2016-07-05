function batchICA(matDir)

% batchICA(matDir)
% --------------------
% Blair - May 9, 2014
% Run ICA on all .mat files in the specified directory. The function reads
% in the .mat file, performs runica on the xRaw variable in each .mat
% file, and writes out the W matrix in the W sub-directory.
%
% See also batchCellICA doICA doCellICA

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
    W = doICA(xRaw);
    %W = f; %%%% for testing
    cd W
    eval(['save ' fileList(f).name ' W'])
    cd ../
    clearvars -except fileList f
end