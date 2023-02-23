% unitTesting_create2DirFeatureToeplitzMatrix.m
% -----------------------------------------------
% Blair - Feb 2023
% 
% Testing out use cases of the matrix.

clear all; close all; clc

f = 1001:1010;
dUse = -5:5;

%% Bad call: No inputs

disp('Bad call: No inputs')
F = create2DirFeatureToeplitzMatrix

%% Bad call: Only 1 input

disp('Bad call: Only 1 input')
F = create2DirFeatureToeplitzMatrix(f)

%% Bad call: Input non-integer delay values

disp('Bad call: Input non-integer delay values')
F = create2DirFeatureToeplitzMatrix(f, [1 2 3.5])

%% Bad call: First input is a matrix, not a vector

disp('Bad call: First input is a matrix, not a vector')
F = create2DirFeatureToeplitzMatrix(randi(10, [5 5]), dUse)

%% Warning call: Specified delays exceed length of input feature vector
thisDUse =[-1000 0 1000];
disp('Warning call: Specified delays exceed length of input feature vector')
disp(['Delays: ' mat2str(thisDUse)])
F = create2DirFeatureToeplitzMatrix(f, thisDUse)

%% Advance and delay 5 samples in either direction

disp('Advance and delay 5 samples in either direction')
F = create2DirFeatureToeplitzMatrix(f, dUse, 1, 1)

%% Same thing, don't specify intercept --> should set to 1

disp('Advance and delay 5 samples in either direction, default intercept')
F = create2DirFeatureToeplitzMatrix(f, dUse, [], 1)

%% Same thing, specify no intercept

disp('Advance and delay 5 samples in either direction, specify no intercept')
F = create2DirFeatureToeplitzMatrix(f, dUse, 0, 1)

%% Call function with no zero-shift
clc

thisDUse = [-5 5];
disp('Call function with no zero-shift')
disp(['Delays: ' mat2str(thisDUse)])
F = create2DirFeatureToeplitzMatrix(f, thisDUse, 1, 1)

%% Call function, delays out of order

clc

thisDUse = [0 1 -1 5 -5];
disp('Call function with delays out of order')
disp(['Delays: ' mat2str(thisDUse)])
F = create2DirFeatureToeplitzMatrix(f, thisDUse, 1, 1)

