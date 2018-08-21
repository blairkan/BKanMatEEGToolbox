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

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2015 Blair Kaneshiro
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
