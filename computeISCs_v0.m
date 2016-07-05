function [rhos, WinXax] = computeISCs_v0(dataIn, fs, doPerm, wLenSec, wShiftSec, permWinSec, pIdx, nPermIter)
% [rhos, WinXax] = computeISCs_v0(dataIn, fs, doPerm, wLenSec, wShiftSec, 
% permWinSec, pIdx, nPermIter)
% ------------------------------------------------------------------------
% Blair - April 1, 2016
% This function is the first attempt to move the computation of
% (time-resolved) ISCs into a standalone function. Right now all the inputs
% must be entered. A future version will take in optional arguments using
% an input parser. The function outputs the matrix rhos, which is of size
% nCorrWins x nPairs x nIter -- will be a 3d matrix if doing permutation
% iterations, 2d if not. It also outputs WinXax, which contains x-axis
% infor for plotting at min, mean, and max of correlation windows.
%
% Note that the function forces nPermIter = 1 if doPerm == 0

% Display whether doing permutation or original condition
if doPerm
    disp(['Analysis mode: Permutation'])
else disp(['Analysis mode: Original'])
end

% Get window length and hop size in SAMPLES
wLenSamp = round(fs * wLenSec);
wShiftSamp = round(fs * wShiftSec);
% disp(['Corr win len in samples: ' num2str(wLenSamp)])
% disp(['Corr win len in seconds: ' num2str(wLenSec)])

% Get total number of samples in the trial
totalSamples = size(dataIn, 1);

% Construct the correlation windows
nCorrWins = floor((totalSamples-wLenSamp)/wShiftSamp + 1);
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

% Get partition windows for the song if doing permutations (same
% ordered windows for any RCs of the current song)
if doPerm
    permWinLenSamp = permWinSec * fs;
    
    % Using ceiling, thus final perm win will be shorter
    nPermWin = ceil(totalSamples/permWinLenSamp);
    
    disp(['Number of ' num2str(permWinSec) '-sec permutation windows: ',...
        num2str(nPermWin)])
    
    % Making a row cell array to match dimension of elements
    PWin = cell(1, nPermWin);
    
    for p = 1:(nPermWin-1)
        PWin{p} = (p-1)*permWinLenSamp + (1:permWinLenSamp);
    end
    PWin{nPermWin} = ((nPermWin - 1)*permWinLenSamp + 1):totalSamples;
end


if doPerm
    disp(['Permutation condition: Iterating ' num2str(nPermIter) ' times...'])
    nIter = nPermIter;
else
    disp('Original condition: One iteration only')
    nIter = 1;
end

% Initialize the cell to store the ISC output
rhos = nan(nCorrWins, size(pIdx,1), nIter);

tic
for iter = 1:nIter
    theData = dataIn; % This is the original data - time x subjects
    if doPerm
        permData = nan(size(theData)); % time x subjects
        % Create a permuted time index for every subject
        for i = 1:size(theData,2)  % Iterate through subjects
            % Partition-shuffled time indices
            tempTime = cell2mat(PWin(randperm(length(PWin))));
            % Partition-shuffled data for subject i
            permData(:,i) = theData(tempTime,i);
        end
        theData = permData; % Overwrite theData only if permuting
    end
    
    % Compute pairwise ISCs for every pair
    for p = 1:size(pIdx,1)
        rhos(:,p,iter) = compute_cc_fixed(theData(:,pIdx(p,1)), theData(:,pIdx(p,2)),corrWins);
    end
end
toc