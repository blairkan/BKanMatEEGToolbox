function [xOut, fsOut] = doTrioFilter(xIn, fsIn, highpassHz, notchHz, D, doPlots)
% [xOut, fsOut] = doTrioFilter(xIn, fsIn, highpassHz, [notchHz], D, doPlots)
% --------------------------------------------------------------------------
% This function does notch, highpass, and lowpass/decimation filtering for
% preprocessing of EGI data.
%
% Inputs
% - xIn: Channels-by-time data frame (full recording, not epoch, preferred)
% - fsIn: Sampling rate of the input data, in Hz
% - hpHz: Cutoff frequency for the highpass filter, in Hz
% - [nHz]: Low and high freqs for notch filter, in Hz (vector of length 2)
% - D: Decimation factor.
% - doPlot: Boolean of whether to plot the results (default = 1)
%
% Outputs
% - xOut: The channels-by-time-filtered data frame
% - fsOut: The decimated sampling rate (fsIn / D)
%
% Filter info
% - All filters use filtfilt and are therefore zero-phase. Notch and
% highpass filter order is as reported (double the designed filter) due to
% the forward and backward filtering.
% - Notch: 8th-order Butterworth filter
%   2nd order x 2 (notch) x 2 (filtfilt) = 8th order
% - Highpass: 8th-order Butterworth filter
%   4th order x 2 (filtfilt) = 8th order
% - Lowpass/downsample: 'decimate' function uses 16th-order Chebyshev Type I
% followed by temporal downsampling. Note that the lowpass cutoff frequency
% here is 0.8 the final Nyquist: f_cut = 0.8 * (fsIn / 2) / D
%
% Other notes
% - A previous attempt to include zero padding did not really help with the
% filter transients at the very start and end of the data. Therefore, we no
% longer do zero padding, but assume that the user can exclude the very
% start and end of the data where the transients are.
% - The IIR (default) setting of filtfilt apparently doubles the filter
% order. So it's a 16th order Chebyshev Type I filter, not 8th order as we
% previously thought.
%
% History
% Blair - Nov 9, 2015 - removing zero padding
% Started Sept 15, 2016

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2015 Blair Kaneshiro
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, 
% this list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright notice, 
% this list of conditions and the following disclaimer in the documentation 
% and/or other materials provided with the distribution.
% 
% 3. Neither the name of the copyright holder nor the names of its 
% contributors may be used to endorse or promote products derived from this 
% software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ?AS IS?
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.

% ccc;
%
% inDir='/usr/ccrma/media/jordan/Experiments/FilterTests2016/RawMAT';
% outDir='/usr/ccrma/media/jordan/Experiments/FilterTests2016/MATOut';
% figDir='/usr/ccrma/media/jordan/Experiments/FilterTests2016/Figs';
%
%
% %%%%%%%%%%%%% Edit this %%%%%%%%%%%%%%%
% % fnIn = 'E12A_S01_20160718_0936'; % no .mat
% fnIn = 'E12A_S02_20160718_1237';
% subStr = 'S02';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cd(inDir)
% load(fnIn)
%
% % Here's the starting sampling rate and data frame
% fsIn = samplingRate;
% xIn = eval(fnIn);
%
% %%%%%% Filter specifications, in Hz %%%%%%%%%%
% highpassHz = 0.3; % Highpass filter cutoff
% notchHz = [59 61]; % We'll reject this range of frequencies
% D = 8; % Decimation factor
% doPlots = 1; % Whether to do the plots
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%% Begin function
% Need to remove this path due to inclusion of filters
rmpath(genpath('/usr/ccrma/media/jordan/Analysis/eeglab11_0_5_4b/functions/octavefunc/signal/'));

verbosePlot = 0; % For debugging only
if nargin < 6
    disp('Doing plots by default.')
    doPlots = 1;
end

nRow = size(xIn, 1); % How many electrodes are we dealing with
disp(['Number of electrodes: ' num2str(nRow)])

% Some plotting things in case we do plots
fSize = 16;
xlim_highpass = [-0.1 highpassHz*4];
xlim_notch = notchHz + [-4 4];
xlim_decimate = fsIn/D/2 * [.8 1.2];
%% Initiate filtering figures

if verbosePlot
    %%% Frequency domain
    figure(102)
    ts101 = tight_subplot(3, 4, 0.05, [.05 .07], [.07 0.01]);
    temp = abs(fft(xIn'));
    % Plot magnitude spectrum around frequencies to be notch and hp filtered
    fAxIn = linspace(0, fsIn, size(xIn, 2)); % Frequency index for plotting
    axes(ts101(1))
    plot(fAxIn, temp); grid on; xlim(xlim_highpass)
    title('Raw', 'fontsize', fSize)
    ylabel(['Highpass ' num2str(highpassHz) 'Hz'])
    axes(ts101(5))
    plot(fAxIn, temp); grid on; xlim(xlim_notch)
    ylabel(['Notch ' mat2str(notchHz) 'Hz'])
    axes(ts101(9))
    plot(fAxIn, temp); grid on; xlim(xlim_decimate)
    ylabel(['Decimate ' num2str(D) 'x'])
end

%% FILTER 1: Highpass filter - 8th order Butterworth

% Input filter order is 4. Doubled by filtfilt --> 8
[bHighpass,aHighpass] = butter(4, highpassHz * 2/fsIn, 'high');
disp('Highpass filtering...')
xHighpass = nan(size(xIn));
for i = 1:nRow
    xHighpass(i,:) = filtfilt(bHighpass, aHighpass, xIn(i,:)); % Zero phase
end
disp('Done.')
disp(' ')

if verbosePlot
    %%% Frequency domain
    figure(102)
    % Plot magnitude spectrum around frequencies to be notch and hp filtered
    temp = abs(fft(xHighpass'));
    axes(ts101(2))
    plot(fAxIn, temp); grid on; xlim(xlim_highpass)
    title('Highpass', 'fontsize', fSize)
    axes(ts101(6))
    plot(fAxIn, temp); grid on; xlim(xlim_notch)
    axes(ts101(10))
    plot(fAxIn, temp); grid on; xlim(xlim_decimate)
end

%% FILTER 2: Notch filter - 8th order Butterworth

% Input filter order is 2. Doubled by notch, doubled by filtfilt --> 8
[bNotch, aNotch] = butter(2, [notchHz] * 2/fsIn, 'stop');

% Initialize the output data matrix
xNotch = nan(size(xHighpass));

disp('Notch filtering...')
for i = 1:nRow
    xNotch(i,:) = filtfilt(bNotch, aNotch, xHighpass(i,:));
end
disp('Done.')
disp(' ')

if verbosePlot
    %%% Frequency domain
    figure(102)
    % Plot magnitude spectrum around frequencies to be notch and hp filtered
    temp = abs(fft(xNotch'));
    axes(ts101(3))
    plot(fAxIn, temp); grid on; xlim(xlim_highpass)
    title('Notch', 'fontsize', fSize)
    axes(ts101(7))
    plot(fAxIn, temp); grid on; xlim(xlim_notch)
    axes(ts101(11))
    plot(fAxIn, temp); grid on; xlim(xlim_decimate)
end

%% FILTER 3: Decimate - 8th order Chebyshev + temporal downsample

xDecimate = [];
disp('Decimating...')
for i = 1:nRow
    xDecimate(i,:) = decimate(xNotch(i,:), D);
end
disp('Done.')

%%%%% HERE ARE THE OUTPUTS %%%%%%%%%%%
fsOut = fsIn / D;
xOut = xDecimate;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
if doPlots
    %%% Time domain - Raw data
    figure(100)
    tAxIn = linspace(0, 15, 15*fsIn);
    % Plot first and last 15 secs of data w/ zero padding
    subplot(4, 2, 1)
    plot(tAxIn,xIn(:,1:(15*fsIn))'); grid on; axis tight
    title('First 15 secs of raw data')
    subplot(4, 2, 2)
    plot(tAxIn,xIn(:,(end-(15*fsIn)+1):end)'); grid on; axis tight
    title('Last 15 secs of raw data')
    % Plot the full raw data
    subplot(4, 1, 2)
    plot(xIn'); grid on; axis tight
    title('Full data frame - raw')
    %%% Time doman - Filtered data
    tAxDec = linspace(0, 15, 15*fsOut);
    subplot(4, 2, 5)
    plot(tAxDec,xOut(:, 1:(fsOut*15))');
    grid on; axis tight
    title('First 15 secs of filtered data')
    subplot(4, 2, 6)
    plot(tAxDec,xOut(:, (end-15*fsOut+1):end)');
    grid on; axis tight
    title('Last 15 secs of filtered data')
    subplot(4, 1, 4)
    plot(xOut'); grid on; axis tight
    title('Full data frame - filtered')
    
    figure(101)
    %%% Frequency domain - full output FFT range
    % Do output first to get ylim
    fAxOut = linspace(0, fsOut, size(xOut, 2));
    XOUT = abs(fft(xOut'));
    subplot 413
    plot(fAxOut, XOUT); grid on; xlim([0 fsOut/2 * 1.2])
    ylOut = ylim;
    title('Filtered data', 'fontsize', fSize)
    % Input
    fAxIn = linspace(0, fsIn, size(xIn,2));
    XIN = abs(fft(xIn'));
    subplot 411
    plot(fAxIn, XIN); grid on; xlim([0 fsOut/2 * 1.2]); ylim(ylOut)
    title('Raw data', 'fontsize', fSize)
    
    %%% Frequency domain - frequencies of interest
    subplot 434
    plot(fAxIn, XIN); grid on; xlim(xlim_highpass)
    title(['HP: ' num2str(highpassHz) 'Hz'])
    subplot 435
    plot(fAxIn, XIN); grid on; xlim(xlim_notch)
    title(['Notch: ' mat2str(notchHz) 'Hz'])
    subplot 436
    plot(fAxIn, XIN); grid on; xlim(xlim_decimate)
    title(['D: ' num2str(D) 'x (fs=' num2str(fsOut) 'Hz)'])
    
    subplot(4, 3, 10)
    plot(fAxOut, XOUT); grid on; xlim(xlim_highpass)
    title(['HP: ' num2str(highpassHz) 'Hz'])
    subplot(4, 3, 11)
    plot(fAxOut, XOUT); grid on; xlim(xlim_notch)
    title(['Notch: ' mat2str(notchHz) 'Hz'])
    subplot(4, 3, 12)
    plot(fAxOut, XOUT); grid on; xlim(xlim_decimate)
    title(['D: ' num2str(D) 'x (fsOut=' num2str(fsOut) 'Hz)'])
    
end
%%
if verbosePlot
    figure(102)
    fAxDec = linspace(0, fsOut, size(xOut, 2));
    temp = abs(fft(xOut'));
    axes(ts101(4))
    disp('Plotting highpass...')
    tic
    plot(fAxDec, temp); grid on; xlim(xlim_highpass)
    title('Decimate', 'fontsize', fSize)
    toc
    axes(ts101(8))
    disp('Plotting notch...')
    tic
    plot(fAxDec, temp); grid on; xlim(xlim_notch)
    toc
    axes(ts101(12))
    disp('Plotting decimate...')
    tic
    plot(fAxDec, temp); grid on; xlim(xlim_decimate)
    toc
end
%%%% End function
% %% Save the figures
% cd(figDir)
% if doPlots
%     figure(100)
%     set(gcf, 'PaperPosition', [0 0 14 12]);
%     fnOut = [subStr '_trioFilter_timeDomain_' ...
%         datestr(now, 'yyyymmdd')];
%     saveas(gcf, [fnOut '.png'])
%
%     figure(101)
%     set(gcf, 'PaperPosition', [0 0 14 12]);
%     fnOut = [subStr '_trioFilter_freqDomain_' ...
%         datestr(now, 'yyyymmdd')];
%     saveas(gcf, [fnOut '.png'])
% end
%
% if verbosePlot
%     figure(102)
%     set(gcf, 'PaperPosition', [0 0 14 12]);
%     fnOut = [subStr '_trioFilter_VERBOSE_' ...
%         datestr(now, 'yyyymmdd')];
%     saveas(gcf, [fnOut '.png'])
% end



