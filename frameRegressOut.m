function xOut = frameRegressOut(xIn, frameLenSec, VEOGData, HEOGData, fs)

% xOut = frameRegressOut(xIn, frameLenSec, VEOGData, HEOGData, fs)
% -----------------------------------------------------------------
% Blair - Oct. 21, 2015
% Adapted from Jacek script - Apr. 14, 2015
% (see regressOutEOGInWindows_fromJacek20150414.m in this directory)
%
% This script performs the regressOut procedure on shorter time frames of
% the data rather than across the full frame. The original script suggested
% 5-second time windows, though window length may want to be longer, or
% perhaps regressOut should be run directly on song-level data frames.
%
% Inputs:
% - xIn: The channels x time full input data matrix
% - frameLenSec: Desired frame length, in seconds
% - VEOGData: Vector of VEOG data (can be row or column). Must have same
% number of elements as xIn has columns.
% - HEOGData: Vector of HEOG data (can be row or column). Must have same
% number of elements as xIn has columns.
% - fs: Sampling rate
%
% Output:
% - xOut: The output data matrix

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2015 Jacek P. Dmochowski and Blair Kaneshiro
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

% Compute window length in samples
winLenSamp=frameLenSec*fs;

% Compute number of windows - the last window will be longer
nWins=round(size(xIn,2)/winLenSamp);

% Make sure that EOG vectors are rows
HEOGData = HEOGData(:)'; VEOGData = VEOGData(:)';

% Regress out separately for each window
for w=1:nWins
    if w == nWins
        % Last window goes to the last column of the data frame
        wIdx = ((w-1)*winLenSamp+1):size(xIn,2);
    else
        wIdx = (w-1)*winLenSamp + (1:winLenSamp);
    end
    disp(['Window ' num2str(w) ' of ' num2str(nWins) ': Length = ' num2str(length(wIdx))])
    xOut(:,wIdx) = regressOut(xIn(:,wIdx), [HEOGData(wIdx); VEOGData(wIdx)]);
%     windx=(w-1)*winLenSamp+1:w*winLenSamp;
%     eog=cat(1,data(8,windx)+data(25,windx),data(125,windx)-data(128,windx));
%     xOut(:,windx) = regressOut(xIn(:,windx),eog);
end