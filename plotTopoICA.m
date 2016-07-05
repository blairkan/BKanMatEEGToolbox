function plotTopoICA(W, badCh, toPlot)

% plotTopoICA(W, badCh, toPlot)
% ----------------------------
% Blair
% January 27, 2015
% Pass in the ICA matrix W, vector of bad channels, and vector of source
% numbers to plot. Function will plot the projections of selected ICA
% components.
%
% See also multiplotICAResults

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

figure()
for i = 1:length(toPlot)
    subplot (1,length(toPlot),i)
    topoplot(Wi(:,toPlot(i)), locs)
    title([num2str(toPlot(i))], 'fontSize', 16)
end
