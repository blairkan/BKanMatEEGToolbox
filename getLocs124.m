function locs124 = getLocs124()

% locs124 = getLocs124()
% --------------------------------------------
% Blair - March 30, 2015
% This function returns the locations of 124 channels for topoplots.
% No vertex (Cz)
% Usage:
% locs124 = getLocs124();
% topoplot(valuesToPlot, locs124);

locFile = 'Hydrocel GSN 128 1.0.sfp'
ll = readlocs(locFile);
locs124 = ll([4:127]);