function visualizeRecordingEndings(varStr, inDir, fNames, doDCCorr, nMsec, fs, sgt, fSize)
% visualizeRecordingEndings(varStr, inDir, fNames, doDCCorr nMsec, fs, sgt, fSize)
% -------------------------------------------------------------------------
% Blair - Feb 15, 2024
%
% This function visualizes the endings of the specified set of recordings.
%
% Required inputs
% - varStr: String for determining which variable to load in each input
%   .mat file. The specified string will be indexed as ['*' varStr '*'].
%
% Optional inputs
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
% - fSize: Font size. If empty or not specified, will default to 10 for
%   subplots. sgtitle will be 2*fSize.

%% Verify the inputs

% Input 1: Var str
assert(nargin >= 1, ['At least 1 input is required: The string to ' ...
    'index variables in loaded .mat files.'])

% Input 2: Input directory
if nargin < 2 || isempty(inDir), inDir = pwd; end

% Input 3: List of filenames
if nargin < 3 || isempty(fNames)
    tempF = dir([inDir filesep '*.mat']);
    fNames = {tempF.name};
end
nFiles = length(fNames);
assert(nFiles > 0, 'No files were indexed! Check indexing parameters.')

% Input 4: doDCCorr
if nargin < 4 || isempty(doDCCorr), doDCCorr = 0; end

% Input 5: nMsec
if nargin < 5 || isempty(nMsec), nMsec = 100; end

% Input 6: fs
if nargin < 6 || isempty(fs), fs = 1000; end

% Input 7: sgt
if doDCCorr, dccs = 'DC corrected'; else dccs = 'no DC correction'; end
sgtbase = ['Last ' num2str(nMsec) ' msec, ' dccs];
if nargin < 7 || isempty(sgt), sgtt = sgtbase;
else, sgtt = [sgt ': ' sgtbase]; end

% Input 8: fSize
if nargin < 8 || isempty(fSize), fSize = 10; end

%% Make the plot

figure()
tcl = tiledlayout ('flow');
visSamp = nMsec * fs / 1000; % Dimensional analysis

for i = 1:nFiles

    thisFnIn = fNames{i};
    THIS = load([inDir filesep thisFnIn], ['*' varStr '*']);
    
    if doDCCorr
        thisXInVis = dcCorrect(double(cell2mat(struct2cell(THIS))));
    else
        thisXInVis = double(cell2mat(struct2cell(THIS)));
    end
   
    nexttile(tcl)
    plot(thisXInVis(:, (end-visSamp+1):end)');
    xlim('tight'); box off; grid on
    title(thisFnIn, 'interpreter', 'none')
    set(gca, 'fontsize', fSize)
    xlabel('Time (samp)'); ylabel('Amplitude (\muV)')
    
end

tempsg = sgtitle(sgtt, 'interpreter', 'none');
tempsg.FontSize = 2*fSize;