function visualizeRCTopo125(AVec, cBar, cLim, mSize)
% visualizeRCTopo125(AVec, cBar, cLim, mSize)
% --------------------------------------------------
% Blair - Feb 14, 2024
%
% This function takes in a forward-model vector and renders a topoplot
% using the modified plotOnEgi function.
%
% Inputs
% - AVec (required): Vector of forward-model "A" vector weights to plot.
%   The function expects a vector of length 125.
% - cBar (optional): Whether to render a colorbar. If empty or not entered,
%   will default to 'false'.
% - cLim (optional): Specified cLim [min max]. If empty or not entered,
%   will default to [-max(abs(AVec)) max(abs(AVec))].
% - mSize (optional): Marker size for the plot. If empty or not entered,
%   will default to 0.1.

%%% Check for / manage inputs
% Input 1: The "A" vector
assert(nargin >= 1, 'This function requires at least one input (the "A" vector).');
assert(isvector(AVec), 'The "A" input must be a vector.')

% Input 2: cBar
if nargin < 2 || isempty(cBar), cBar = 0; end

% Input 3: cLim
if nargin < 3 || (cBar && isempty(cLim))
    cLim = [-max(abs(AVec)) max(abs(AVec))]; end

% Input 4: Marker size for the topoplot
if nargin < 4 || isempty(mSize), mSize = 0.1; end

plotOnEgi129_NG(nanFill125To129(AVec), mSize)
if cBar
    colorbar;
    set(gca, 'clim', cLim);
end