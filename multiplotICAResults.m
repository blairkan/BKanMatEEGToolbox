function multiplotICAResults(W, xICA, corrV, corrH, badCh, sourceNumbers, figName)

% multiplotICAResults(W, xICA, corrV, corrH, badCh, sourceNumbers, figName)
% --------------------------------------------------------------------
% Blair
% August 18, 2015
%
% Create a multiplot of printed ICA-EOG correlation values, topoplot of the
% forward-model projection of the source, and the timecourse of this EEG
% component.
%
% Inputs
%   - W matrix (for topoplots)
%   - xICA (for source-space time series)
%   - corrV (for printed corr vals)
%   - corrH (for printed corr vals)
%   - badCh (for correcting locs)
%   - sourceNumbers (which sources are we looking at)
%   - figure name (optional)
%
% Adapted from plotTopoICA function, which did the following:
% Pass in the ICA matrix W, vector of bad channels, and vector of source
% numbers to plot. Function will plot the projections of selected ICA
% components.
%
% Note that this version is written for active electrodes 1:124.
%
% See also plotTopoICA

%%%% If there are more than 6 sources to plot, split into > 1 figure %%%%
if length(sourceNumbers) > 6
    nFigs = ceil(length(sourceNumbers)/6);
    disp(sprintf('Splitting into %d figures', nFigs));
    for i = 1:(nFigs-1)
       multiplotICAResults(W, xICA, corrV, corrH, badCh,...
           sourceNumbers((1:6) + (i-1)*6),...
           [figName ' - ' num2str(i) ' of ' num2str(nFigs)])
    end
    multiplotICAResults(W, xICA, corrV, corrH, badCh,...
        sourceNumbers((i*6+1):end),...
        [figName ' - ' num2str(nFigs) ' of ' num2str(nFigs)])
    return
end

%%%% Load the .sfp file and remove bad channel locations if necessary %%%%
sfpFn = '/usr/ccrma/media/jordan/Analysis/Hydrocel GSN 128 1.0.sfp';
locs = readlocs(sfpFn);
locs = locs(4:127);
% toPlot = [toPlot; 2];  % FOR TESTING THE FUNCTION
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

if nargin == 7
    figure('name', figName, 'numbertitle', 'off')
else
    figure()
end

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
    topoplot(tempTopo, locs);
    % title([num2str(sourceNumbers(i))], 'fontSize', 16)
%     set(gca, 'CLim', [min(tempTopo) max(tempTopo)])
    clear tempTopo
    
    % Timecourse of the source
    subplot(nrow, ncol, (3:ncol) + (i-1) * ncol)
    plot(xICA(sourceNumbers(i), :)); grid on
end
