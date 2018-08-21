function loopWav(inDir, outDir, fn, nRep, IOIMsec)
% function loopWav(inDir, outDir, fn, nRep, IOIMsec)
% ----------------------------------------------------
% Blair - July 23, 2018
%
% This function loads a .wav file fn, and writes out a looped version where
% the input .wav is looped nRep times, with IOIMsec milliseconds in between
% onsets of the sound. Useful for calibrating stimuli with the EGI system.
%
% Required inputs:
% - inDir: Input directory
% - outDir: Output directory
% - fn: Input .wav filename (does not need '.wav' extension)
% - nRep: Number of repetitions
% - IOIMsec: Inter-onset interval, in milliseconds. Or set to zero to do
%   back-to-back repetition of the loaded .wav.
%
% Function will return an error if the length of the .wav file exceeds the
% inter-onset interval.
%
% See also loopAllWavInDir

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

%%%% Dev %%%%
% clear all; close all; clc
% inDir = 'C:\Users\CCRMA-EEG\Documents\Experiments\MATLAB\ACLS2_3_EGIStimCalibration\ACLS2_MVPStims_20180618';
% outDir = 'C:\Users\CCRMA-EEG\Documents\Experiments\MATLAB\ACLS2_3_EGIStimCalibration\ACLS2_loopedMVPStims';
% nRep = 6;
% IOIMsec = 0;
% fn = 'Avowel_150msec_20180618.wav';
%%%%%%%%%%%%%%%

% Remove '.wav' extension if it was included
if strcmpi(fn((end-3):end), '.wav'), fn = fn(1:(end-4)); end
fn

% Make sure IOIMsec is nonnegative
if IOIMsec < 0, error('IOIMsec must be a nonnegative integer.'); end

% Load the .wav file
cd(inDir); [yIn, fs] = audioread([fn '.wav']);
yLenMsec = length(yIn) / fs * 1000; % Length of input file, in msec
disp(['Length of ' fn '.wav: ' sprintf('%.2f', yLenMsec) ' msec.'])

if IOIMsec % If IOIMsec is positive, use that as window length
    
    if yLenMsec > IOIMsec, error('Length of loaded audio file is greater than inter-onset interval.'); end
    disp(['Inter-onset interval: ' sprintf('%.2f', IOIMsec) ' msec.'])
    
    % Created the looped version of the .wav file
    IOISamp = round(IOIMsec / 1000 * fs); % How many time samples per repetition
    yOut = zeros(nRep * IOISamp, size(yIn, 2)); % Initialize output
    for i = 1:nRep
        currIdx = (i-1)*IOISamp + (1:length(yIn)); % Starting point and length
        %     disp(['Rep ' num2str(i) ': .wav inserted starting at time sample ' num2str(currIdx(1))])
        yOut(currIdx,:) = yIn; % Add the loaded content in there
    end
    
else
    disp(['Concatenating ' num2str(nRep) ' back-to-back repetitions of the stimulus.']);
    yOut = repmat(yIn, nRep, 1);
    
end
tAx = ((1:length(yOut))-1) / fs;
figure(); plot(tAx, yOut); title(fn, 'interpreter', 'none')
xlabel('Time (sec)'); ylabel('Amplitude')
axis tight; ylim([-1.1 1.1])

cd(outDir)
fnOut = [fn '_IOIMSec_' num2str(IOIMsec) '_nRep_' num2str(nRep) '_'...
    datestr(now, 'yyyymmdd') '.wav']
audiowrite(fnOut, yOut, fs)
