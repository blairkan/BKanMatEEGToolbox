function F = create2DirFeatureToeplitzMatrix(f, delayUse, addIntercept)
% F = create2DirFeatureToeplitzMatrix(f, delayUse, addIntercept)
% -------------------------------------------------------------
% Blair - January 26, 2023
%
% This function constructs the Toeplitz (convolution) matrix comprising the
% specified positive and negative delays (i.e., delays and advances) of an
% input feature vector.
%
% Inputs: 
% - f: Feature vector (should be T x 1; will transpose if not)
% - delayUse: Ordered set of delays to be imposed on the input feature
%   vector. All values must be integers.
%   - Positive values reflect POSITIVE delays (by which the column feature 
%     vector is shifted down).
%   - Negative values reflect NEGATIVE delays (by which the column feature
%     vector is shifted up).
%   - If the user wishes to include the 0 time shift, it must be included
%     in this input.
% - addIntercept: Whether to additionally include the intercept column
%   (column of 1s) at the end. If not specified, will default to 1.
%
% Outputs: 
% - F: Feature matrix of size [T x ( length(delayUse) + addIntercept )]

% Function history
% Adapted from createFeatureToeplitzMatrix Blair 3/9/2018

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

%% For debugging - comment out if running as function

% ccc; 
% f = 1:20;
% nDelays = 10;
% addIntercept = 1;

%% Check inputs - uncomment if running as function

% Make sure there are at least 2 inputs

% Input 1: Make sure the f input is a vector

% Input 2: Make sure the delayUse input is all integers

% Input 3: If addIntercept is empty or not specified, 



if nargin < 3, addIntercept = 1; end
if nargin < 2, error('Toeplitz matrix: Must input both a feature vector and number of delays.'); end

%%
if ~isvector(f), error('Toeplitz matrix: Input feature vector needs to be a vector.'); end
f = f(:); T = length(f);
if delayUse >= T, warning('Toeplitz matrix: Number of delays exceeds length of feature vector; will have full column(s) of zeros.'); end

if addIntercept, disp('Toeplitz matrix: Adding intercept column of 1s.'); end

% Initialize the matrix
F = nan(T, delayUse+1+addIntercept);

for d = 1:(delayUse+1) % Fill in main body of matrix
    F(:,d) = [zeros(min(d-1,T),1); f(1:(end-(d-1)))];
end
if addIntercept, F(:, end) = 1; end % Add intercept if requested