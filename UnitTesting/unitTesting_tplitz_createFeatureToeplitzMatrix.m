% unitTesting_tplitz_createFeatureToeplitzMatrix.m
% --------------------------------------------------
% Blair - January 18, 2021
%
% Testing equivalence of tplitz (stim2eeg) and createFeatureToeplitzMatrix
% (BKanMatEEGToolbox) as tplitz gives out-of-memory error for long feature
% vectors.

clear all; close all; clc

% For column feature vector f:
% tplitz(f, nNonInterceptCols)
% - Always includes the intercept
% - Number of non-intercept columns includes the zero delay, so if the user
%   specifies 'fs' as the second argument, the TOTAL number of
%   non-intercept columns will be fs (not zero delay + fs delays, as is
%   done in the other function)
% createFeatureToeplitzMatrix(f, nDelays, addIntercept)
% - Can do intercept or not (default is 1)
% - Will include zero delay PLUS nDelays columns
%
% Thus, we expect the following function calls to be equivalent
% - tplitz(f, nDelays+1)
% - createFeatureToeplitzMatrix(f, nDelays, 1)

for l = [100 1000 10000 20000 30000]
    
    disp(['Feature vector length: ' num2str(l)])
    
    f = randi(100, [l 1]);
    
    tic
    t1 = tplitz(f, 81);
    toc
    tic
    t2 = createFeatureToeplitzMatrix(f, 80, 1);
    toc
    assert(isequal(t1, t2))
    disp('Success!')
    disp(' ')
    
end

% Feature vector length: 100
% Elapsed time is 0.005581 seconds.
% Toeplitz matrix: Adding intercept column of 1s.
% Elapsed time is 0.002498 seconds.
% Success!
%  
% Feature vector length: 1000
% Elapsed time is 0.012732 seconds.
% Toeplitz matrix: Adding intercept column of 1s.
% Elapsed time is 0.001540 seconds.
% Success!
%  
% Feature vector length: 10000
% Elapsed time is 1.961885 seconds.
% Toeplitz matrix: Adding intercept column of 1s.
% Elapsed time is 0.003440 seconds.
% Success!
%  
% Feature vector length: 20000
% Elapsed time is 7.659634 seconds.
% Toeplitz matrix: Adding intercept column of 1s.
% Elapsed time is 0.006258 seconds.
% Success!
%  
% Feature vector length: 30000
% Elapsed time is 63.662110 seconds.
% Toeplitz matrix: Adding intercept column of 1s.
% Elapsed time is 0.280018 seconds.
% Success!