function xOut = cube2chRows(xIn)
% ------------------------------
% xOut = cube2chRows(xIn)
% Blair - July 4, 2016
%
% This function takes a 3D electrodes x time x trials
% matrix and reshapes it to an electrodes x concat trial
% 2D matrix. Needs only 1 input.
%
% See also cube2trRows ch2trRows tr2chRows trRows2cube chRows2cube

nCh = size(xIn, 1); % Number of electrodes
N = size(xIn, 2); % Number of time samples per trial
nTr = size(xIn, 3); % Number of trials

xOut = nan(nCh, N*nTr);

for i = 1:nTr
   currCols = (i-1)*N + (1:N);
   xOut(:, currCols) = xIn(:, :, i);
end
