function xOut = imputeBadChannels125(xIn, badChannelList)

% xOut = imputeBadChannels125(xIn, badChannelList)
% ---------------------------------------------
% Blair - November 13, 2015
% 
% This function takes in a 125-channels x time data matrix and list of bad
% channels. It reconstructs the data from each listed bad channel as the
% (nan)mean of the timecourses of its neighboring electrodes. Neighboring 
% electrode information is read from neighboringElectrodes.mat.
%
% The function returns an error in the following condition:
% - A listed bad channel exceeded the number of rows in the data matrix.
% The function returns a warning in the following condition:
% - A row to be imputed contains values other than NaN.
%
% Note that this function operates solely on the input data matrix, so if
% adjacent bad channels need to be imputed, the imputed version of one will
% not be used to impute the other.

% Return error and exit if bad channel numbers exceed number of rows in
% matrix.
if max(badChannelList > size(xIn, 1))
    error('Specified bad channels exeed number of rows in data matrix.')
    return
end

% Load struct with 'neighbors' variable.
load neighboringElectrodes125.mat;

xOut = xIn;

% Sort bad channels so we always reconstruct in ascending channel order
badChannelList = sort(badChannelList);

for i = 1:length(badChannelList)
   currCh = badChannelList(i);
   currNei = neighbors{currCh};
   disp(strvcat({['Bad Channel: ' num2str(currCh)], ...
       ['Reconstructing from nanmean of channels ' mat2str(currNei)]}))
   % Display a warning if the channel to be imputed contains numerical
   % values (is not an empty channel of NaNs).
   if length(find(isnan(xIn(currCh,:)))) < length(xIn(currCh,:))
      warning('This bad channel contains values other than NaN!')
   end
   xOut(currCh,:) = nanmean(xIn(currNei,:),1);
end
