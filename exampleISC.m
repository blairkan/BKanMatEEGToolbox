% exampleISC.m
% -------------
% Blair - April 5, 2016
%
% Quick test to run ISCs on continuous behavioral data

clear all; close all; clc

load behavStructs.mat

% The behavioral responses are stored in contBehav22 and contBehav23. These
% matrices are time x subs with a sampling rate of ~20 Hz.

pIdx = combnk(1:size(contBehav22,2), 2);
fs = 20;

% Check for nans in the data
length(find(isnan(contBehav22)))

% There is now a function to compute ISCs given some inputs:
% [rhos, xaxis] = computeISCs_v0(data, fs, doPermutation, winLenSec,...
%   winShiftSec, permWinLenSec, pIdx, nPermIter)
% Note that if doPermutation is zero, we do just one iteration even if
% nPermIter > 1.

[rhos,~] = computeISCs_v0(contBehav22, fs, 0, 5, 1, 5, pIdx, 1);

% Check for nans in the ISC output
length(find(isnan(rhos)))