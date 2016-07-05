function xDC = dcCorrect(x)

% xDC = dcCorrect(x)
% ----------------------------
% Blair - May 21, 2014
% This function takes in the data matrix x and subtracts from each row
% the mean of that row. (Uses nanmean)

meanOfEachClRow = nanmean(x,2);
mM = repmat(meanOfEachClRow, 1, size(x,2));
xDC = x - mM;