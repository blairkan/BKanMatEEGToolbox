function visualizeRecordingEndArtifact(xIn, fs, secVis, sgt)
% visualizeRecordingEndArtifact(xIn, fs, secVis)
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

