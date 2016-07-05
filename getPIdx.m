function pIdx = getPIdx(nSubs)
% pIdx = getPIdx(nSubs)
% ---------------------------------
% Blair - April 5, 2016
% This function takes in the number of subjects and returns the pIdx matrix
% (all pairwise combinations of subjects) used as input for computing ISCs.

pIdx = combnk(1:nSubs,2);