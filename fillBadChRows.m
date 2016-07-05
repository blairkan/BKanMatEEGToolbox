function x124 = fillBadChRows(xIn, badCh)

% x124 = fillBadChRows(xIn, badCh)
% ----------------------------------
% Blair - May 8, 2014
% This function takes in a data matrix from which bad channel rows may have
% been removed, and reconstitutes those rows with rows of NaN.

% if size(xIn,1) + length(badCh) ~= 124
%     error('Number of bad channels does not match number of missing rows in the data matrix.')
% end

% The row of NaNs to fill in
rowOfNan = nan(1, size(xIn,2));

badCh = sort(badCh); % Make sure we are ascending
x124 = xIn;

for i = 1:length(badCh)
    currBad = badCh(i);
    x124 = [x124(1:(currBad-1),:);
        rowOfNan;
        x124(currBad:end,:)];
end