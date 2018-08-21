function addZeroClickToAllWavInDirectory(inDir, outDir, clickLenMsec)
% addZeroClickToAllWavInDirectory(inDir, outDir, clickLenMsec)
% -------------------------------------------------------------
% Blair - July 20, 2018
%
% This script loads each .wav file in the specified input directory,
% converts to mono if necessary, and then adds a second audio channel which
% contains a click of specified length at the very beginning. Each new
% audio file is saved in the specified output directory.
%
% Required inputs: 
% - inDir: Path to input directory
% - outDir: Path to output directory
%
% Optional input
% - clickLenMsec: Click length, in msec. If not specified, default is 5.
%
% This function returns no variables; simply writes out the .wav files in
% the output directory.

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

if nargin < 3
    disp('No ''clickLenMsec'' value specified. Defaulting to 5 msec.');
    clickLenMsec = 5;
end

if strcmp(inDir, outDir)
    error('Same input and output directory not allowed. Function uses same filename to write output .wav files, which would overwrite input files.')
end

cd(inDir)
fList = dir('*.wav');
fNames = {fList.name};
nFiles = length(fNames);
disp([num2str(nFiles) ' files returned.'])

for i = 1:nFiles
    % Load current input file
    cd(inDir)
    fnIn = fNames{i};
    [thisIn, thisFs] = audioread(fnIn);
    disp(' '); disp(['Loaded file ' fnIn])
    
    % Convert to mono by averaging channels if needed
    if size(thisIn, 2) > 1, thisIn = mean(thisIn, 2); end
    
    % Create the click
    thisClickLenSamp = round(clickLenMsec / 1000 * thisFs);
    
    % Initialize the click channel
    thisClick = zeros(size(thisIn));
    
    % Fill in the click portion of click channel with ones
    thisClick(1:thisClickLenSamp) = 1;
    
    % Combine the audio channel and the click channel
    thisOut = [thisIn thisClick];
    
    % Write out the result
    cd(outDir)
    fnOut = [fnIn(1:(end-4)) '_click.wav'];
    disp(['Writing out file ' fnOut])
    audiowrite(fnOut, thisOut, thisFs);
    clear this*
end