function plotEEGOverlay(x, vertLinePos)
% plotEEGOverlay(x, vertLinePos)
% ----------------------------------------
% Blair - March 13, 2024
%
% This function plots the specified data and optional vertical lines in the
% current axis.
%
% Inputs
% - x (required): Space-by-time data matrix (will be transposed by this
%   function for plotting).
% - vertLinePos (optional): Vector of x-values at which vertical reference
%   lines (for e.g., trial boundaries) should be plotted. If empty or not
%   entered, no lines will be plotted.

%% Validate inputs

assert(nargin > 1, 'This function requires at least one input (the space x time data matrix).')

if nargin < 2 || isempty(vertLinePos), vertLinePos = []; end

%% Do the plot

% Plot the data overlay
p = plot(x'); 
xlim('tight');
box off;

% If specified, plot the vertical lines
yl = get(gca, 'ylim');
grayCol = [.4 .4 .4];
for i = 1:length(vertLinePos)
    hold on
    plot(vertLinePos * ones(1,2), yl);
end

% Move the data overlay to the top
uistack(p, 'top');