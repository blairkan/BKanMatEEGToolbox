function loopAllWavInDir(inDir, outDir, nRep, IOIMsec)
% function loopAllWavInDir(inDir, outDir, nRep, IOIMsec)
% -------------------------------------------------------
% Blair - July 23, 2018
%
% This script calls the loopWav function on all files in the specified
% input directory, and writes out the looped versions into the output
% directory. The loopWav function loops a given .wav files nRep times, with
% an inter-onset interval of IOIMsec.
%
% Required inputs:
% - inDir: Input directory
% - outDir: Output directory
% - nRep: Number of repetitions
% - IOIMsec: Inter-onset interval, in milliseconds
%
% See also loopWav

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

cd(inDir)
fList = dir('*.wav');
fName = {fList.name}; % Cell array of just the .wav filenames
% fName

% Remove files starting with '.'
for i = length(fName) : -1 : 1
   if strcmp(fName{i}(1), '.'), fName(i) = []; end
end
% fName
% return

disp(['Processing ' num2str(length(fName)) ' files.'])

for i = 1:length(fName)
   loopWav(inDir, outDir, fName{i}, nRep, IOIMsec); 
end