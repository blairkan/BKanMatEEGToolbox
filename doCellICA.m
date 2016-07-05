function W = doCellICA(x)

% W = doCellICA(x)
% -------------------
% Blair - August 24, 2015
% This function runs ICA on every matrix contained in the cell array X.
% It runs infomax extended ICA using the EEGLAB 'runica' function,
% returning a cell array W containing the same number of W matrices as
% there were input data matrices in X.
%
% See also doICA batchICA batchCellICA

for i = 1:length(x)
    [weights, sphere] = runica(x{i}, 'extended', 1);
    W{i} = weights * sphere;
    clear weights sphere
end