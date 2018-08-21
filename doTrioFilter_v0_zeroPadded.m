% function [xOut, fsOut] = doTrioFilter(xIn, fsIn, [nHz], hpHz, D)
% [xOut, fsOut] = doTrioFilter(xIn, fsIn, [nHzLow nHzHigh], hpHz, D)
% --------------------------------------------------------------------
% Blair - Sept 15, 2016
%
% This function does notch, highpass, and lowpass/decimation filtering for
% preprocessing of EGI data (making up for their faulty filters).
%
% Inputs
% - xIn: Channels-by-time data frame (exported from EGI)
% - fsIn: Sampling rate of the input data, in Hz
% - [nHz]: Low and high freqs for notch filter, in Hz (vector of length 2)
% - hpHz: Cutoff frequency for the highpass filter, in Hz
% - D: Decimation factor.
%
% Outputs
% - xOut: The final filtered data
% - fsOut: The final sampling rate (fsIn / D)
%
% Filter info
% - All filters use filtfilt and are therefore zero-phase. Notch and
% highpass filter order is as reported (double the designed filter) due to
% the forward and backward filtering.
% - Notch: 8th-order Butterworth filter
% - Highpass: 4th-order Butterworth filter
% - Lowpass/downsample: 'decimate' function uses 8th-order Chebyshev Type I
% followed by temporal downsampling. Note that the lowpass cutoff frequency
% here is 0.8 the final Nyquist: f_cut = 0.8 * (fsIn / 2) / D
%
% Other notes
% - To avoid filter startup artifacts, five seconds of zeros are appended
% to the start and end of xIn before filtering, and removed at the end.

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2016 Blair Kaneshiro
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

ccc;

inDir='/usr/ccrma/media/jordan/Experiments/FilterTests2016/RawMAT';
outDir='/usr/ccrma/media/jordan/Experiments/FilterTests2016/MATOut';
figDir='/usr/ccrma/media/jordan/Experiments/FilterTests2016/Figs';


%%%%%%%%%%%%% Edit this %%%%%%%%%%%%%%%
% fnIn = 'E12A_S01_20160718_0936'; % no .mat
fnIn = 'E12A_S02_20160718_1237';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(inDir)
load(fnIn)

% Here's the starting sampling rate and data frame
fsIn = samplingRate;
xIn = eval(fnIn);

%%%%%% Filter specifications, in Hz %%%%%%%%%%
FilterSpec.notchHz = [59 61]; % We'll reject this range of frequencies
FilterSpec.highpassHz = 0.3; % Highpass filter cutoff
FilterSpec.D = 8; % Decimation factor
doPlots = 1; % Whether to do the plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need to remove this path due to inclusion of filters
rmpath(genpath('/usr/ccrma/media/jordan/Analysis/eeglab11_0_5_4b/functions/octavefunc/signal/'));

nRow = size(xIn, 1); % How many electrodes are we dealing with

disp(['Loaded ' fnIn])
disp(['Number of electrodes: ' num2str(nRow)])

%% PRE-FILTERING: Zero pad the signal

% Create a matrix of nRow x 5 seconds of zeros that we will append to the
% beginning and end of the data frame for filtering
fiveSecZeros = zeros(nRow, 5 * fsIn);

% Here's an index to keep track so we can pull out the data later
zerosIdx = [fiveSecZeros(1,:) ones(1, size(xIn,2)) fiveSecZeros(1,:)];

% Here's the zero padded data frame TO INPUT TO FIRST FILTER
xZeros = [fiveSecZeros xIn fiveSecZeros];

%% Initiate filtering figures

if doPlots
    %%% Time domain
    figure(100)
    tAxIn = linspace(0, 15, 15*fsIn);
    % Plot first and last 15 secs of data w/ zero padding
    subplot(5,2,[1 3])
    plot(tAxIn,xZeros(:,1:(15*fsIn))'); grid on; axis tight
    title('First 15 secs of zero-padded raw data')
    
    subplot(5,2,[2 4])
    plot(tAxIn,xZeros(:,(end-(15*fsIn)+1):end)'); grid on; axis tight
    title('Last 15 secs of zero-padded raw data')
    
    % Plot first and last 15 secs of zerosIdx
    subplot(5, 2, 9)
    plot(tAxIn,zerosIdx(1:(15*fsIn))); grid on; axis tight; ylim([-.1 1.1])
    title('First 15 secs of zerosIdx')
    subplot(5, 2, 10)
    plot(tAxIn,zerosIdx((end-(15*fsIn)+1):end)); grid on; axis tight; ylim([-.1 1.1])
    title('Last 15 secs of zerosIdx')
    
    %%% Frequency domain
    figure(101)
    % Plot magnitude spectrum around frequencies to be notch and hp filtered
    fAxIn = linspace(0, fsIn, size(xZeros, 2)); % Frequency index for plotting
    subplot(3, 2, 1)
    plot(fAxIn, abs(fft(xZeros'))); grid on; xlim(FilterSpec.notchHz)
    title(['Mag spec raw at notch freqs (' mat2str(FilterSpec.notchHz) ' Hz)'])
    subplot(3, 2, 3)
    plot(fAxIn, abs(fft(xZeros'))); grid on; xlim([0 FilterSpec.highpassHz*1.2])
    title(['Mag spec raw at highpass freq (' num2str(FilterSpec.highpassHz) ' Hz)'])
    subplot(3, 2, 5)
    plot(fAxIn, abs(fft(xZeros'))); grid on; xlim([fsIn/FilterSpec.D/2*0.8 fsIn/FilterSpec.D/2*1.2])
    title(['Mag spec raw at decimiation fs/2 (' num2str(fsIn/FilterSpec.D/2) ' Hz)'])
end

%% FILTER 1: Notch filter - 8th order Butterworth

% Input filter order is 2. Doubled by notch, doubled by filtfilt --> 8
[bNotch, aNotch] = butter(2, [FilterSpec.notchHz] * 2/fsIn, 'stop');

% Initialize the output data matrix
xNotch = nan(size(xZeros));

disp('Notch filtering...')
for i = 1:nRow
    xNotch(i,:) = filtfilt(bNotch, aNotch, xZeros(i,:));
end
disp('Done.')
disp(' ')

if doPlots
    figure(101)
    subplot(3, 2, 2)
    plot(fAxIn, abs(fft(xNotch'))); grid on; xlim(FilterSpec.notchHz)
    title('Mag spec after notch filtering')
end

%% FILTER 2: Highpass filter - 8th order Butterworth

% Input filter order is 4. Doubled by filtfilt --> 8
[bHighpass,aHighpass] = butter(4, FilterSpec.highpassHz * 2/fsIn, 'high');
disp('Highpass filtering...')
xHighpass = nan(size(xNotch));
for i = 1:nRow
    xHighpass(i,:) = filtfilt(bHighpass, aHighpass, xNotch(i,:)); % Zero phase
end
disp('Done.')
disp(' ')

if doPlots
   figure(101)
   subplot(3, 2, 4)
   plot(fAxIn, abs(fft(xHighpass'))); grid on; xlim([0 FilterSpec.highpassHz*1.2])
   title('Mag spec after highpass filtering')
end

%% FILTER 3: Decimate - 8th order Chebyshev + temporal downsample

xDecimate = [];
disp('Decimating...')
for i = 1:nRow
    xDecimate(i,:) = decimate(xHighpass(i,:), FilterSpec.D);
end
disp('Done.')

% Downsample zerosIdx so we know which cols of data to pull back out
zerosIdxDownsamp = downsample(zerosIdx, FilterSpec.D); 
%%
%%%%% HERE ARE THE OUTPUTS %%%%%%%%%%%
fs = fsIn / FilterSpec.D;
xTrioFiltered = xDecimate(:, zerosIdxDownsamp == 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if doPlots
   fAxDec = linspace(0, fs, size(xDecimate, 2));
   figure(101)
   subplot(3, 2, 6)
   plot(fAxDec, abs(fft(xDecimate'))); grid on; xlim([fsIn/FilterSpec.D/2*0.8 fsIn/FilterSpec.D/2*1.2])
   title(['Mag spec after decimation (fs/2=' num2str(fsIn/FilterSpec.D/2) 'Hz)'])
   
   figure(100)
   tAxDec = linspace(0, 15, 15*fs);
   subplot(5, 2, [5 7])
   plot(tAxDec,xDecimate(:, 1:(fs*15))');
   grid on; axis tight
   title('First 15 secs of zero-padded filtered data')
   subplot(5, 2, [6 8])
   plot(tAxDec,xDecimate(:, (end-15*fs+1):end)');
   grid on; axis tight
   title('Last 15 secs of zero-padded filtered data')
end
%%
% Final figure of time domain raw and filtered
if doPlots
   figure(102)
   subplot 211; plot(xIn'); grid on; axis tight
   subplot 212; plot(xTrioFiltered'); grid on; axis tight; ylim([-3000 3000])
end
%% Save the figures
cd(figDir)
figure(100)
set(gcf, 'PaperPosition', [0 0 14 12]);
fnOut = ['S02_trioFilter_zeroPadded_timeDomain_' ...
    datestr(now, 'yyyymmdd')];
saveas(gcf, [fnOut '.png'])

figure(101)
set(gcf, 'PaperPosition', [0 0 14 12]);
fnOut = ['S02_trioFilter_zeroPadded_freqDomain_' ...
    datestr(now, 'yyyymmdd')];
saveas(gcf, [fnOut '.png'])

figure(102)
set(gcf, 'PaperPosition', [0 0 14 12]);
fnOut = ['S02_trioFilter_zeroPadded_beforeAfter_' ...
    datestr(now, 'yyyymmdd')];
saveas(gcf, [fnOut '.png'])



