function [xOut, FSPECS] = doTrioFilterNoDS(xIn, fs, hpHz, nHz, lpHz, doPlots)
% [xOut, FSPECS] = doTrioFilter(xIn, fsIn, hpHz, [nHz], lpHz, doPlots)
% --------------------------------------------------------------------------
% Blair - December 2023
%
% This function does notch, highpass, and lowpass filtering for
% preprocessing of EGI data. It does not downsample the data. 
%
% Inputs
% - xIn: Channels-by-time data frame (full recording, not epoch, preferred)
% - fs: Sampling rate of the input data, in Hz
% - hpHz: Cutoff frequency for the highpass filter, in Hz
% - [nHz]: Low and high freqs for notch filter, in Hz (vector of length 2)
% - lpHz: Cutoff frequency for the lowpass filter, in Hz.
% - doPlot: Boolean of whether to plot the results (default = 1)
%
% Outputs
% - xOut: The channels-by-time-filtered data frame
% - FSPECS: Struct with coefficients of all filters
%
% Filter info
% - All filters use filtfilt and are therefore zero-phase. Notch and
% highpass filter order is as reported (double the designed filter) due to
% the forward and backward filtering.
% - Notch: 8th-order Butterworth filter
%   2nd order x 2 (notch) x 2 (filtfilt) = 8th order
% - Highpass: 8th-order Butterworth filter
%   4th order x 2 (filtfilt) = 8th order
% - Lowpass: 16th-order Chebyshev Type I filter as used in 'decimate'. 
%   8th order x 2 (filtfilt) = 16th order
%
% Other notes
% - A previous attempt to include zero padding did not really help with the
% filter transients at the very start and end of the data. Therefore, we no
% longer do zero padding, but assume that the user can exclude the very
% start and end of the data where the transients are.
% - Note that filtfilt actually adds adequate time-reversed data to the
% start and end of the epoch to account for filter transients. 
% - The IIR (default) setting of filtfilt apparently doubles the filter
% order. So it's a 16th order Chebyshev Type I filter, not 8th order as we
% previously thought.

% History
% Blair - Adapting from [xOut, fsOut] = doTrioFilter(xIn, fsIn, hpHz, [nHz], D, doPlots)
% - Decoupling 3 filtering steps from final downsample
% - Move plotting into separate function
% - Address the warning about filtfilt
% Blair - Nov 9, 2015 - removing zero padding
% Started Sept 15, 2016

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2023 Blair Kaneshiro
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


%% Check data
% Make sure the native MATLAB version of filtfilt (and not e.g., the EEGLAB
% version) is being used. EEGLAB path would look something like this: 
% 'eeglab11_0_5_4b/functions/octavefunc/signal/'
assert(isequal(...
    regexp(...
    which('filtfilt'), ...
    regexptranslate('wildcard', '*MATLAB*toolbox*signal*signal*filtfilt.m')), ...
    1), ...
    'Function is not using builtin version of filtfilt!')

%% Figure init stuff 
verbosePlot = 0; % For debugging only
if nargin < 6
    disp('Doing plots by default.')
    doPlots = 1;
end

nRow = size(xIn, 1); % How many electrodes are we dealing with
disp(['Number of electrodes: ' num2str(nRow)])

% Some plotting things in case we do plots
fSize = 16;
xlim_highpass = [-0.1 hpHz*4];
xlim_notch = nHz + [-4 4];
xlim_lowpass = lpHz * [.75 1.25];

if verbosePlot
    %%% Frequency domain
    figure(102)
    ts101 = tight_subplot(3, 4, 0.05, [.05 .07], [.07 0.01]);
    temp = abs(fft(xIn'));
    % Plot magnitude spectrum around frequencies to be notch and hp filtered
    fAx = linspace(0, fs, size(xIn, 2)); % Frequency index for plotting
    axes(ts101(1))
    plot(fAx, temp); grid on; xlim(xlim_highpass)
    title('Raw', 'fontsize', fSize)
    ylabel(['Highpass ' num2str(hpHz) 'Hz'])
    axes(ts101(5))
    plot(fAx, temp); grid on; xlim(xlim_notch)
    ylabel(['Notch ' mat2str(nHz) 'Hz'])
    axes(ts101(9))
    plot(fAx, temp); grid on; xlim(xlim_lowpass)
    ylabel(['Decimate ' num2str(lpHz) 'x'])
end

%% FILTER 1: Highpass filter - 8th order Butterworth

% Input filter order is 4. Doubled by filtfilt --> 8
[bHighpass,aHighpass] = butter(4, hpHz * 2/fs, 'high');
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
    plot(fAx, temp); grid on; xlim(xlim_highpass)
    title('Highpass', 'fontsize', fSize)
    axes(ts101(6))
    plot(fAx, temp); grid on; xlim(xlim_notch)
    axes(ts101(10))
    plot(fAx, temp); grid on; xlim(xlim_lowpass)
end

FSPECS.bHighpass = bHighpass;
FSPECS.aHighpass = aHighpass;

%% FILTER 2: Notch filter - 8th order Butterworth

% Input filter order is 2. Doubled by notch, doubled by filtfilt --> 8
[bNotch, aNotch] = butter(2, [nHz] * 2/fs, 'stop');

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
    plot(fAx, temp); grid on; xlim(xlim_highpass)
    title('Notch', 'fontsize', fSize)
    axes(ts101(7))
    plot(fAx, temp); grid on; xlim(xlim_notch)
    axes(ts101(11))
    plot(fAx, temp); grid on; xlim(xlim_lowpass)
end

FSPECS.bNotch = bNotch;
FSPECS.aNotch = aNotch;

%% FILTER 3: Lowpass - 16th order Chebyshev

% Input filter order is 8. Doubled by filtfilt --> 16
lowpassRipple = 0.05; % Passband ripple, inDB
[bLowpass, aLowpass] = cheby1(8, lowpassRipple, lpHz * 2/fs); % Lowpass by default
sFilt = 'Chebyshev I';
FSPECS.lowpassRipple = lowpassRipple;

% Here's an 8th order Butterworth instead
% [bLowpass, aLowpass] = butter(8, lpHz * 2/fs); % Lowpass by default
% sFilt = 'Butterworth';
% [z, p, k] = butter(8, lpHz * 2/fs);
% sos = zp2sos(z, p, k);

figure(500)
freqz(bLowpass, aLowpass, 0:.1:100, fs);
sgtitle(sFilt)
subplot 211; xlim([0 100]); ylim([-80 10])
subplot 212; xlim([0 100]); ylim([-800 0])
% hfvt = fvtool(bLowpass, aLowpass, sos, 'FrequencyScale', 'log');
% legend(hfvt,'TF Design','ZPK Design')

xLowpass = nan(size(xNotch));
disp('Lowpass filtering...')
for i = 1:nRow
   xLowpass(i,:) = filtfilt(bLowpass, aLowpass, xNotch(i,:)); 
end
disp('Done.')

%%%%% HERE IS THE OUTPUT %%%%%%%%%%%%%
xOut = xLowpass;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FSPECS.bLowpass = bLowpass;
FSPECS.bHighpass = bHighpass;
FSPECS.lpType = sFilt;

%%
if doPlots
    %%% Time domain - Raw data
    figure(200)
    tAx = linspace(0, 15, 15*fs);
    % Plot first and last 15 secs of data w/ zero padding
    subplot(4, 2, 1)
    plot(tAx,xIn(:,1:(15*fs))'); grid on; axis tight
    title('First 15 secs of raw data')
    subplot(4, 2, 2)
    plot(tAx,xIn(:,(end-(15*fs)+1):end)'); grid on; axis tight
    title('Last 15 secs of raw data')
    % Plot the full raw data
    subplot(4, 1, 2)
    plot(xIn'); grid on; axis tight
    title('Full data frame - raw')
    %%% Time doman - Filtered data
    subplot(4, 2, 5)
    plot(tAx,xOut(:,1:(15*fs))');
    grid on; axis tight
    title('First 15 secs of filtered data')
    subplot(4, 2, 6)
    plot(tAx,xOut(:,(end-(15*fs)+1):end)');
    grid on; axis tight
    title('Last 15 secs of filtered data')
    subplot(4, 1, 4)
    plot(xOut'); grid on; axis tight
    title(['Full data frame - filtered - ' sFilt])
    
    figure(201)
    %%% Frequency domain - full output FFT range
    % Do output first to get ylim
    fAx = linspace(0, fs, size(xIn,2));
    XOUT = abs(fft(xOut'));
    subplot 413
    plot(fAx, XOUT); grid on; xlim([0 lpHz * 1.25])
    ylOut = ylim;
    title(['Filtered data - ' sFilt], 'fontsize', fSize)
    % Input
    XIN = abs(fft(xIn'));
    subplot 411
    plot(fAx, XIN); grid on; xlim([0 lpHz * 1.25]); ylim(ylOut)
    title('Raw data', 'fontsize', fSize)
    
    %%% Frequency domain - frequencies of interest
    subplot 434
    plot(fAx, XIN); grid on; xlim(xlim_highpass)
    title(['HP: ' num2str(hpHz) 'Hz'])
    subplot 435
    plot(fAx, XIN); grid on; xlim(xlim_notch)
    title(['Notch: ' mat2str(nHz) 'Hz'])
    subplot 436
    plot(fAx, XIN); grid on; xlim(xlim_lowpass)
    title(['LP: ' num2str(lpHz) 'Hz'])
    
    subplot(4, 3, 10)
    plot(fAx, XOUT); grid on; xlim(xlim_highpass)
    title(['HP: ' num2str(hpHz) 'Hz'])
    subplot(4, 3, 11)
    plot(fAx, XOUT); grid on; xlim(xlim_notch)
    title(['Notch: ' mat2str(nHz) 'Hz'])
    subplot(4, 3, 12)
    plot(fAx, XOUT); grid on; xlim(xlim_lowpass)
    title(['LP: ' num2str(lpHz) 'Hz'])
    
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
    plot(fAxDec, temp); grid on; xlim(xlim_lowpass)
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



