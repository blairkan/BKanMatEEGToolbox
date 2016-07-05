function locs125 = getLocs125()

% locs125 = getLocs125()
% --------------------------------------------
% Blair - March 30, 2015
% This function returns the locations of 124 channels PLUS vertex for
% topoplots.
% Usage:
% locs125 = getLocs125();
% topoplot(valuesToPlot, locs125);

locFile = 'Hydrocel GSN 128 1.0.sfp'
ll = readlocs(locFile);
locs125 = ll([4:127 132]);