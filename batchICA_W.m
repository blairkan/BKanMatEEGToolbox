function batchICA_W(matDir)
% batchICA_W(matDir)
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