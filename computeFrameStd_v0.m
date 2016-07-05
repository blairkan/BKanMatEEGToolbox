function [stds, WinXax] = computeFrameStd_v0(dataIn, fs, wLenSec, wShiftSec)
% [rhos, WinXax] = computeISCs_v0(dataIn, fs, doPerm, wLenSec, wShiftSec, 
% permWinSec, pIdx, nPermIter)
% ------------------------------------------------------------------------
% Blair - April 1, 2016
% Using ISC windows and computing per-subject standard deviation of behav
% data in that frame as a measure of activity over time.
%

nSubs = size(dataIn,2);

% Get window length and hop size in SAMPLES
wLenSamp = round(fs * wLenSec);
wShiftSamp = round(fs * wShiftSec);

% Get total number of samples in the trial
totalSamples = size(dataIn, 1);

% Construct the correlation windows
nCorrWins = floor((totalSamples-wLenSamp)/wShiftSamp + 1);
disp(['Number of subjects: ' num2str(nSubs)])
disp(['Song length in samples: ' num2str(totalSamples)])
disp(['Number of correlation windows: ' num2str(nCorrWins)])
corrWins = cell(nCorrWins,1);
for w = 1:nCorrWins-1
    corrWins{w,1} = (w-1)*wShiftSamp + (1:wLenSamp);
end
% Final window can be longer
corrWins{nCorrWins,1} = ((nCorrWins-1) * wShiftSamp + 1):totalSamples;

% Save min/mean/max time in seconds from each window as x-axis for
% plotting
WinXax.mean = cellfun(@mean, corrWins)/fs;
WinXax.max = cellfun(@max, corrWins)/fs;
WinXax.min = cellfun(@min, corrWins)/fs;


% Initialize the cell to store the ISC output
stds = nan(nCorrWins, nSubs);

tic
for i = 1:nCorrWins
    stds(i,:) = std(dataIn(corrWins{i},:));
end
toc