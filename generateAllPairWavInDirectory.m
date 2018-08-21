% function generateAllPairWavInDirectory(inDir, outDir, silentMsec)
% generateAllPairWavInDirectory(silentMsec) 
% -------------------------------------------------------
% Blair - June 25, 2018
%
% This function loads every .wav file in the specified directory and
% outputs all pairs of files as a new set of .wav files. 
%
% Required input: Directory (absolute or relative path should work)
% Optional input: How many msec of silence to insert between the elements
% in each pair (defaults to 0).
%
% Later: 
% - If not all sampling rates are the same, we currently upsample to the
%   HIGHEST sampling rate in the set. We could later allow for another
%   input to converge on a different sampling rate, or a sampling rate not
%   even found among the loaded input files.
% - Allow user to specify list of files to load, if not wanting all files.

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2018 Blair Kaneshiro
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

% if nargin < 2
%     error('Must provide at least an input and output directory.')
% end
% 
% if nargin < 3
%     disp('No silent interval specified. Setting silent interval between stims to 0.');
%     silentMsec = 0;
% elseif silentMsec < 0
%     warning('Silent interval should be a nonnegative number. Setting to 0.');
%     silentMsec = 0;
% end

outDir = 'MVPPairs_20180625';
inDir = 'MVPStims_20180618';
silentMsec = 1000;

startDir = pwd;

% Go to input directory and load all the files.
cd(inDir)
pwd
fList = dir('*.wav');
nIn = length(fList);
disp(['Returned ' num2str(nIn) ' input .wav files.'])

% Initialize variables
allInWav = cell(nIn,1); allUseWav = allInWav;
allInFs = nan(nIn,1);
allOutWav = cell(nIn); 
allOutNames = cell(nIn);

% Load the data
for i = 1:nIn
    disp(['Loading ' fList(i).name])
    [allInWav{i}, allInFs(i)] = audioread(fList(i).name);
end

% Bring to consistent sampling rate
maxFs = max(allInFs); % This is the Fs we will use.
disp(' ')
disp(['Bringing all .wav files to ' num2str(maxFs) 'Hz.'])
nZeros = round(silentMsec / 1000 * maxFs);
for i = 1:nIn
    
    % If there's a fs mismatch, resample the audio and store
    if allInFs(i) ~= maxFs
        temp = resample(allInWav{i}, maxFs, allInFs(i));
        
    % Otherwise, just copy over the audio
    else
        temp = allInWav{i};
    end
    allUseWav{i} = 0.9 * temp/max(abs(temp));
    
    figure()
    plot(allUseWav{i})
end
allUseFs = repmat(maxFs, nIn, 1);



% Combine all the pairs of files and create output filename string in 2D
% cell arrays.
disp(' ')
disp('Combining files into pairs.')
for i = 1:nIn
    currI = allUseWav{i};
   for j = 1:nIn
       currJ = allUseWav{j};
       allOutWav{i, j} = [currI; zeros(nZeros, 1); currJ];
       allOutNames{i, j} = [fList(i).name(1:6) '-' fList(j).name(1:6) '.wav'];
   end
end


% Go to output directory and write everything out.
cd(startDir) % In case using relative paths
cd(outDir)
pwd
disp(' ')
disp('Writing out the output .wav files.')
for i = 1:nIn
   for j = 1:nIn
      audiowrite(allOutNames{i,j}, allOutWav{i,j}, maxFs); 
   end
end


% The end
cd(startDir) % Go back to the starting directory