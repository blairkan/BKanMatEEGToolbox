function percentOverThreshold = getPercentOverThreshold(data, threshold)

% percentOverThreshold = getPercentOverThreshold(data, threshold)
% ----------------------------------------------------------------
% Blair
% August 19, 2015
%
% This function takes in a vector (e.g., of voltages), and returns the
% percent of voltage magnitudes that exceed the threshold of interest. Note
% that values are strictly greater than (>, not >=).

percentOverThreshold = 100 * length(find(abs(data) > threshold)) / length(data);