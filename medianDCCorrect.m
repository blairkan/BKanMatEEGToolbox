function xDC = medianDCCorrect(x)

% xDC = medianDCCorrect(x)
% ----------------------------
% Blair - March 24, 2015
% This function takes in the data matrix x and subtracts from each row
% the MEDIAN of that row (using nanmedian). This version might be
% preferable to dcCorrect (which uses nanmean) as it is less affected by
% large transients in the signal.

medianOfEachClRow = nanmedian(x,2);
mM = repmat(medianOfEachClRow, 1, size(x,2));
xDC = x - mM;