function visualizeRecordingEndings(inDir, fNames, doDCCorr, nMsec, fs, sgt)
% visualizeRecordingEndings(inDir, fNames, doDCCorr nMsec, fs, sgt)
% -----------------------------------------------------------
% Blair - Feb 15, 2024
%
% This function visualizes the endings of the specified set of recordings.
%
% Inputs (all optional)
% - inDir: Input directory in which files are stored. If empty or not
%   entered, will default to pwd.
% - fNames: Cell array of filenames to be loaded. If empty or not entered,
%   the function will index and load all .mat files in the input directory.
% - doDCCorr: Whether to DC-correct each recording prior to visualization.
%   If empty or not entered, will default to 0.
% - nMsec: The last [nSamp] milliseconds of the recording to be visualized.
%   If empty or not entered, will default to 100.
% - fs: The sampling rate of the data, in Hz. If empty or not entered, will
%   default to 1000.
% - sgt: String to display as the sgtitle of the plot along with function-
%   specified string with information about nMsec and doDCCorr. If empty or
%   not specified, only the function-specified string will be shown.

%% Verify the inputs

% Input 1: Input directory
if nargin < 1 || isempty(inDir), inDir = pwd; end

% Input 2: List of filenames
if nargin < 2 || isempty(fNames)
    tempF = dir([inDir filesep '*.mat']);
    fNames = {tempF.name};
end

% Input 3: doDCCorr
if nargin < 3 || isempty(doDCCorr), doDCCorr = 0; end

% Input 4: nMsec
if nargin < 4 || isempty(nMsec), nMsec = 100; end

% Input 5: fs
if nargin < 5 || isempty(fs), fs = 1000; end

% Input 6: sgt
if doDCCorr, dccs = '(DC corrected)'; else dccs = '(no DC correction)'; end
sgtbase = ['Last ' num2str(nMsec) ',' ];
if nargin < 6 || isempty(sgt), sgtt = sgtbase;
else, sgtt = [sgt ': ' sgtbase]; end

keyboard