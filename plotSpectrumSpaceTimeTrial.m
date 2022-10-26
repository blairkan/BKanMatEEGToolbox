function h = plotSpectrumSpaceTimeTrial(xIn, fs, channelUse, xMax, plotAnno)
% plotSpectrumSpaceTimeTrial(xIn, fs, channelUse, xMax, plotAnno)
% ----------------------------------------------------------
% Creator: Blair Kaneshiro, Nov 2022
%
% This function takes in (1) a 3D [space x time x trial] (or 2D
% [space x time] matrix), (2) sampling rate of the data, and (3) optional
% channel number(s) to plot. It then does the following:
% - Average across the trial dimension (can be singelton for 2D input).
%   Note that the function uses nanmean in case there are missing values.
% - Computes FFT
% - Plots single specified trial or all trials overlaid
%
% Inputs (required)
% - xIn: 3D [space x time x trial] or 2D [space x time] matrix
% - fs: Sampling rate of the data
%
% Inputs (optional)
% - channelUse: Array of which electrodes to plot. If not specified or
%   empty, will default to all channels.
% - xMax: If exists and is not empty, will set the upper x-lim
%   value in the plot.
% - plotAnno: Whether to plot xlabel, ylabel, and title. If not specified
%   or empty, will default to true.
%
% Outputs:
% - f: Handle to current axis

%% Check inputs

assert(nargin >= 2, ...
    'At least two inputs are required: The input data, and the sampling rate.')

[nSpace, nTime, nTrial] = size(xIn);

if nargin < 3 || isempty(channelUse)
    channelUse = 1:nSpace;
    plotStr = 'all electrodes'
else
    plotStr = ['electrode(s) ' mat2str(channelUse)];
end

if nargin < 5 || isempty(plotAnno), plotAnno = 1; end

%% Prepare data

xAvg = nanmean(xIn, 3); % Space x time
XAVG = abs(fft(xAvg')); % Frequency x space
XPLOT = XAVG(:, channelUse);
fAx = computeFFTFrequencyAxis(nTime, fs);

%% Plot the data

h = plot(fAx, XPLOT);
box off; grid on
if exist('xMax') && ~isempty(xMax), xlim([0 xMax]); end
if plotAnno
    xlabel('Frequency (Hz)'); ylabel('FFTMag')
    title(['Magnitude spectrum, ' plotStr])
end


