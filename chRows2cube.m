function xOut = chRows2cube(xIn, N)
% ----------------------------------
% xOut = chRows2cube(xIn, N)
% Blair - July 4, 2016
%
% This function takes a 2D electrodes x concatenated trials matrix and
% reshapes it to a 3D electrodes x time x trials matrix.
%
% The number of columns in xIn must be an integer multiple of N (integer
% number of trials.) The function will return an error if this is not the
% case.
%
% See also trRows2cube ch2trRows tr2chRows cube2trRows cube2chRows

% Check to make sure that it's an integer number of trials
nTr = size(xIn, 2)/N;
if rem(nTr, 1) ~= 0
   error('Number of columns in input is not integer divisible by N.');
end

nCh = size(xIn, 1);
xOut = nan(nCh, N, nTr);

for i = 1:nTr
   currCols = (i-1)*N + (1:N);
   xOut(:,:,i) = xIn(:,currCols);
   clear curr*
end