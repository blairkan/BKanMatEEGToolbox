function xAR = doAR(x)

% xAR = doAR(x)
% ----------------
% Blair - May 8, 2014
% Convert a data matrix to average reference by subtracting the mean of
% all rows from each data point. (Uses nanmean)

xAR = x - ones(size(x,1),1) * nanmean(x,1);