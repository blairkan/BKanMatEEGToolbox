function visualizeRecordingEndArtifact(xIn, fs, secVis, sgt, fNum)
% visualizeRecordingEndArtifact(xIn, fs, secVis, sgt, fNum)
% -------------------------------------------------------
% Blair - Feb 7, 2024
%
% This function visualizes an entire recording, as well as the ending
% portion at various ranges of seconds.
%
% INPUTS
% - xIn (required): The input data frame (electrodes x time)
% - fs (optional): Sampling rate of the data. If empty or not entered, will
%   default to 1000 Hz (1 kHz).
% - secVis (optional): Up to 3 values of how many seconds from the end of
%   the recording to visualize. If empty or not entered, will default to
%   [5 1 0.1]. It is the responsibility of the user for any entered values
%   to correspond to an integer number of time samples at the sampling rate
%   of the data.
% - sgt (optional): Optional string to display as the main figure title
%   (sgtitle).
% - fNum (optional): Which figure number to put the plot in. If empty or
%   not entered, the function will create a new figure.

% Function history
% - 2/7/2024: Adapted from WTISC_dev_artifacts_assessEndTransient.m

%% Verify or assign inputs

% Input 1: Data
assert(nargin >=1, 'This function requires at least one input (electrode x time data matrix).')

% Input 2: Sampling rate
if nargin < 2 || isempty(fs), fs = 1000; end

% Input 3: Which seconds to visualize
if nargin < 3 || isempty(secVis), secVis = [5 1 0.1]; end
assert(length(secVis) <= 3, 'No more than 3 secVis values can be specified.')

% Input 4: Whether to include an sgtitle
if nargin < 4 || isempty(sgt), sgt = []; end

% Input 5: Whether to specify the figure number
if nargin < 5 || isempty(fNum), fNum = []; end

%% Do the stuff

fSize = 12;

if isempty(fNum), figure(); else figure(fNum); end

subplot(2, 1, 1)
plot(xIn')
xlim('tight')
title('All data')
set(gca, 'fontsize', fSize)
box off; grid on
xlabel('Time (samp)')
ylabel('Amplitude (\muV)')

nSecVis = length(secVis);
for i = 1:nSecVis
    subplot(2, nSecVis, i+nSecVis)
    plot(xIn(:, (end-secVis(i)*fs+1):end)');
    xlim('tight')
    title(['Last ' num2str(secVis(i)) ' sec'])
    set(gca, 'fontsize', fSize)
    box off; grid on
    xlabel('Time (samp)')
    ylabel('Amplitude (\muV)')
end

if ~isempty(sgt), sgtitle(sgt, 'interpreter', 'none'); end

