function multiplotICAResults_ekgStandalone(W, xICA, corrV, corrH, badCh, sourceNumbers, plotSamp, fs, tStr)

% multiplotICAResults_ekgStandalone(W, xICA, corrV, corrH, badCh, sourceNumbers, plotSamp, fs, [tStr])
% --------------------------------------------------------------------
% Blair
% November 2020
%
% Create a multiplot of printed ICA-EOG correlation values, topoplot of the
% forward-model projection of the source, and the timecourse of this EEG
% component. This is the standalone version of multiplotICAResults_EKG, and
% no longer needs EEGLAB to load the sensor locations (uses pre-saved locs
% file rather than readlocs) or render the topoplots (uses
% topoplotStandalone rather than topoplot). 
%
% Inputs
%   - W matrix (for topoplots)
%   - xICA (for source-space time series)
%   - corrV (for printed corr vals)
%   - corrH (for printed corr vals)
%   - badCh (for correcting locs)
%   - sourceNumbers (which sources are we looking at)
%   - plotSamp (which time samples of data to plot)
%   - fs (sampling rate)
%
% Adapted from plotTopoICA function, which did the following:
% Pass in the ICA matrix W, vector of bad channels, and vector of source
% numbers to plot. Function will plot the projections of selected ICA
% components.
%
% Note that this version is written for active electrodes 1:124.
%
% Adapted from multiplotICAResults(W, xICA, corrV, corrH, badCh, sourceNumbers, figName)
%
% See also plotTopoICA multiplotICAResults

% Function history
% - 2/12/2025: Adapted from multiplotICAResults_ekg(W, xICA, corrV, corrH, badCh, sourceNumbers, plotSamp, fs)
% - 2/5/2025: Copied from https://github.com/blairkan/BKanMatEEGToolbox

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2021 Blair Kaneshiro
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

%%%% If there are more than 6 sources to plot, split into > 1 figure %%%%
if length(sourceNumbers) > 6
    nFigs = ceil(length(sourceNumbers)/6);
    disp(sprintf('Splitting into %d figures', nFigs));
    for i = 1:(nFigs-1)
       multiplotICAResults_ekgStandalone(W, xICA, corrV, corrH, badCh,...
           sourceNumbers((1:6) + (i-1)*6), plotSamp, fs)
    end
    multiplotICAResults_ekgStandalone(W, xICA, corrV, corrH, badCh,...
        sourceNumbers((i*6+1):end), plotSamp, fs)
    return
end

%%%% NEW FOR THIS VERSION: Load the pre-saved locs file
load('locsEGI124.mat')

% Remove coordinates for bad channels
if length(badCh)>0
    locs(badCh) = [];
end

% Columns of the inverse matrix give projection strengths of respective
% components.
Wi = inv(W);

% Some properties of the plot
nrow = length(sourceNumbers);
ncol = 10;
corrFontSize = 18;

figure()

% Load tight subplot AFTER initializing the figure
% addpath(genpath('/usr/ccrma/media/jordan/Analysis/tight_subplot'));
hh = tight_subplot(nrow, ncol, 0.0005, 0);

for i = 1:length(sourceNumbers)
    % Print the source number and correlation vals
    axes(hh(1 + (i-1) * ncol));
    set(gca, 'Visible', 'off'); % remove the default axes
    text(-0.5, 0.5, ...
        sprintf('Source %d \ncorrV = %0.4f \ncorrH = %0.4f', ...
        sourceNumbers(i), corrV(sourceNumbers(i)), corrH(sourceNumbers(i))), ...
        'fontsize', corrFontSize);
    
    % Source topoplot
    axes(hh(2 + (i-1) * ncol))
    tempTopo = Wi(:, sourceNumbers(i));
    topoplotStandalone(tempTopo, locs);
    % title([num2str(sourceNumbers(i))], 'fontSize', 16)
%     set(gca, 'CLim', [min(tempTopo) max(tempTopo)])
    clear tempTopo
    
    % Timecourse of the source
    subplot(nrow, ncol, (3:ncol) + (i-1) * ncol)
    plot(plotSamp / fs, xICA(sourceNumbers(i), plotSamp)); grid on
    xlabel('Time (sec)')
end

if nargin == 9
    sgtitle(tStr, 'interpreter', 'none', 'fontsize', corrFontSize)
end
