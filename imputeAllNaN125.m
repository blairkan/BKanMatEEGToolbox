function xOut = imputeAllNaN125(xIn, useOut)

% xOut = imputeAllNaN125(xIn, [useOut])
% ---------------------------------------------
% Blair - December 1, 2015 - adapted from imputeBadChannels125.m
% 
% This function takes in a 125-channels x time data matrix and list of bad
% channels. It looks for NaNs in every channel and fills them in the 
% nanmean of its neighbors. Neighboring electrode information is read from 
% neighboringElectrodes125.mat.
%
% Note that this function can operate solely on the input data matrix (in 
% which case the order in which channels are considered has no effect) or 
% can operate iteratively on the output matrix, in which case previously
% imputed values can contribute to subsequent neighbors' imputation. The
% latter case seems to be necessary for certain transients, as the NaN bad
% samples operation will at times Nan out an electrode plus all of its
% neighbors. In the latter case, too, this function can be called more than
% once to assist in imputing all values of the matrix.

% Load struct with 'neighbors' variable.
load neighboringElectrodes125.mat;

xOut = xIn;

if nargin<2
    useOut = 0;
end

for i = 1:size(xOut,1)
   % Get indices of NaN data in current electrode (columns of interest)
   currNaN = find(isnan(xIn(i,:))); 
   % Get neighbors of current electrode
   currNei = neighbors{i};
   if useOut
       xOut(i,currNaN) = nanmean(xOut(currNei,currNaN),1);
   else
       xOut(i,currNaN) = nanmean(xIn(currNei, currNaN),1);
   end
end
