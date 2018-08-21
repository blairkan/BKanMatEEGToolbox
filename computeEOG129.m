function [VEOG, HEOG] = computeEOG129(x129, V, H, flag)

% [VEOG, HEOG] = computeEOG129(x129, V, H ,[flag])
% -----------------------------------------------------------------
% Blair - November 20, 2017
% 
% This function takes in the 129-channel electrodes-by-time data matrix, as
% well as VEOG and HEOG electrode numbers, and computes the VEOG and HEOG
% channels. It also checks VEOG and HEOG channel assignments and verifies 
% that they are appropriate, before making the computation. The function 
% will return an error message if VEOG or HEOG electrode selections are not
% appropriate. The user may override the error check (e.g., in cases where 
% both 8 and 25 are not usable for VEOG), by entering any value as a 4th 
% input. In this case, the function will display a warning and proceed by
% taking the mean of the override-specified electrodes.
%
% Example usage
% [veog, heog] = computeEOG129(x129, [8 126], [125 128]);
% [veog, heog] = computeEOG129(x129, 8, [1 32], 1); % VEOG override
%
% Acceptable VEOG specifications: 
% [8 25], [8 25 126 127], [8 126], [25 127]
% Acceptable HEOG specifications:
% [1 32], [125 128], [1 32 125 128]
%
% Inputs
%   - x129: Data frame with 129 rows, variable columns
%   - V, H: Numbers or vectors of electrode numbers. 
%
% Outputs
%   - VEOG, HEOG: Column vectors of VEOG and HEOG channels (convert back 
%       to rows to construct the EOG matrix).
%
% See also getEOG, getEOGMulti

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2017 Blair Kaneshiro
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

% Adapted from getEOGMulti - Blair - August 19, 2015
% Adapted from getEOG - Blair - May 6, 2014

if ~ismember(size(x129, 1), [128 129])
    error('Input data matrix must contain 128 or 129 rows.')
end

if nargin<3
    error('Not enough inputs. Please provide a data matrix, as well as VEOG and HEOG electrode selections.')
end

% VEOG computations
vSort = sort(V);
if isequal(vSort, [8 25])
    VEOG = (x129(8,:) + x129(25,:)) / 2;
elseif isequal(vSort, [8 25 126 127])
    VEOG = (x129(8,:) + x129(25,:)) / 2 - (x129(126,:) + x129(127,:)) / 2;
elseif isequal(vSort, [8 126])
    VEOG = (x129(8,:) - x129(126,:)) / 2;
elseif isequal(vSort, [25 127])
    VEOG = (x129(25,:) - x129(127,:)) / 2;
elseif nargin == 4
    warning(['User override specifies VEOG electrodes ' mat2str(V) '.'])
    disp('Computing mean of user-override VEOG electrodes...')
    VEOG = mean(x129(V,:), 1);
else
   error([mat2str(V) ' is not an appropriate electrode selection for VEOG computation.']) 
end
disp(['VEOG computed from ' mat2str(V) '.'])

% HEOG computations
hSort = sort(H);
if isequal(hSort, [1 32])
    HEOG = (x129(1,:) - x129(32,:)) / 2;
elseif isequal(hSort, [125 128])
    HEOG = (x129(125,:) - x129(128,:)) / 2;
elseif isequal(hSort, [1 32 125 128])
    HEOG = (x129(1,:) + x129(125,:)) / 2 - (x129(32,:) + x129(128,:)) / 2;
elseif nargin == 4
    warning(['User override specifies HEOG electrodes ' mat2str(H) '.'])
    disp('Computing mean of user-override HEOG electrodes...')
    HEOG = mean(x129(H,:), 1);
else
    error([mat2str(H) ' is not an appropriate electrode selection for HEOG computation.'])
end
disp(['HEOG computed from ' mat2str(H) '.'])


% Make sure they are columns
VEOG = VEOG(:);
HEOG = HEOG(:);