function W = doICA(x)

% W = doICA(x)
% -------------------
% Blair - May 6, 2014
% This function runs the EEGLAB ica function and returns the unmixing
% matrix W that will transform the data matrix from channel space to source
% space.
%
% See also doCellICA batchICA batchCellICA

[weights, sphere] = runica(x, 'extended', 1);
W = weights * sphere;