function F = create2DirFeatureToeplitzMatrix(f, delayUse, addIntercept, printDebug)
% F = create2DirFeatureToeplitzMatrix(f, delayUse, addIntercept, printDebug)
% --------------------------------------------------------------------------
% Blair - January 26, 2023
%
% This function constructs the Toeplitz (convolution) matrix comprising the
% specified negative and positive delays (i.e., advances and delays) of an
% input feature vector.
%
% Required inputs: 
% - f: Feature vector (should be T x 1; will transpose if not)
% - delayUse: Set of delays by which to shift the input feature vector. 
%   Shifts will be implemented in whatever order the delays are given.
%   - All values must be integers to represent sample-wise delays.
%   - Negative values reflect NEGATIVE delays (by which the column feature
%     vector is shifted up).
%   - Positive values reflect POSITIVE delays (by which the column feature 
%     vector is shifted down).
%   - If the user wishes to include the 0 time shift, it must be included
%     in this input.
%   - The maximal negative or positive delay should not exceed the length
%     of the original feature vector, since this would result in columns
%     equal to zero. If such delays are included, the function will print a
%     warning.
%
% Optional inputs:
% - addIntercept: Boolean of whether to additionally include the intercept 
%   column (column of 1s) at the end. If not specified, will default to 1.
% - printDebug: Boolean of whether to print debug messages in the console. 
%   If empty or not specified, will detault to 0.
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

%% Check inputs

% Make sure there are at least 2 inputs
assert(nargin >= 2, 'FEATURE TOEPLITZ MATRIX: At least 2 inputs are required: Feature vector and vector of delays.')

% Input 1: Make sure the f input is a vector (not a matrix)
assert(isvector(f), 'FEATURE TOEPLITZ MATRIX: First input "f" must be a vector.')

% Input 2: Make sure the delayUse input is all integers
isaninteger = @(x)isfinite(x) & x==floor(x);
assert(all(isaninteger(delayUse(:))), ...
    'FEATURE TOEPLITZ MATRIX: All specified delays in second input "delayUse" must be integers.');

% Input 3: If addIntercept is empty or not specified, set it to true
if nargin < 3 || isempty(addIntercept), addIntercept = 1; end

% Input 4: If printDebug is empty or not specified, set it to false
if nargin < 4 || isempty(printDebug), printDebug = 0; end

% Make sure the maximal delay does not exceed the length of the feature
% vector.
if(any(abs(delayUse) > length(f)))
   warning('FEATURE TOEPLITZ MATRIX: One or more specified delays exceeds length of input feature vector; output will have full column(s) of zeros.') 
end

%% Create the feature Toeplitz matrix

% Convert input feature vector to column
f = f(:); 

% Get lengths of feature vector and delays vector
T = length(f);
D = length(delayUse);

% Initialize the output matrix
F = nan(T, D + addIntercept);

%%% Fill in the matrix
% Fill in shifted vectors one at a time
for d = 1:D
    
    thisDelay = delayUse(d); % Current signed delay
    thisAbsDelay = abs(thisDelay); % Current abs delay
    
    if thisDelay < 0 % Neg val => advance (shift up)
        F(:, d) = [f(thisAbsDelay+1:end); zeros(min(thisAbsDelay, T), 1)];
    else             % Nonneg val ==> delay (shift down) or no delay
        F(:, d) = [zeros(min(thisAbsDelay, T), 1); f(1:end-thisAbsDelay)];   
    end
    
    clear this*
end

% If intercept column is requested, add it
if addIntercept
    
    if printDebug, disp('FEATURE TOEPLITZ MATRIX: Adding intercept column of 1s.'); end
    F(:, end) = 1;

end