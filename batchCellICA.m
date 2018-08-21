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

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2015 Blair Kaneshiro
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