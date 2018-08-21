function [VEOG, HEOG] = computeEOG256(x256, V, H, flag)

% [VEOG, HEOG] = computeEOG256(x256, V, H ,[flag])
% -----------------------------------------------------------------
% Blair - January 8, 2018
% 
% This function takes in the 256-channel electrodes-by-time data matrix, as
% well as VEOG and HEOG electrode numbers, and computes the VEOG and HEOG
% channels. It checks VEOG and HEOG channel assignments, and verifies 
% that they are appropriate, before making the computation. The function 
% will return an error message if VEOG or HEOG electrode selections are not
% appropriate. The user can override the error check (e.g., in cases where 
% neither 37 nor 18 are usable for VEOG), by entering any value as a 4th 
% input. In this case, the function will display a warning and proceed by
% taking the mean of the override-specified electrodes.
%
% Example usage
% [veog, heog] = computeEOG256(x256, [37 244], [1 54]);
% [veog, heog] = computeEOG256(x256, [38 244], [1 54], 1); % VEOG override
%
% Acceptable VEOG specifications (need not be ordered): 
% [37 244] (+,-), [18 234] (+,-), [37 18] (+,+), [37 18 234 244] (++,--)
% Acceptable HEOG specifications (need not be ordered):
% [54 1] (+,-), [252 225] (+,-), [54 252 1 226] (++,--)
%
% Inputs
%   - x256: Data frame with 256 rows, variable columns
%   - V, H: Scalars or vectors of electrode numbers. 
%
% Outputs
%   - VEOG, HEOG: Column vectors of VEOG and HEOG channels (convert back 
%       to rows to construct the EOG matrix).
%
% See also computeEOG129, getEOG, getEOGMulti

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2018 Blair Kaneshiro
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

% Adapated from computeEOG129 - Blair Nov 20, 2017
% Adapted from getEOGMulti - Blair - August 19, 2015
% Adapted from getEOG - Blair - May 6, 2014

if size(x256, 1) ~= 256
    error('Input data matrix must contain 256 rows.')
end

if nargin<3
    error('Not enough inputs. Please provide a data matrix, as well as VEOG and HEOG electrode selections.')
end

% VEOG computations
vSort = sort(V);
if isequal(vSort, [18 37]) % Mean(left, right above)
    VEOG = (x256(18,:) + x256(37,:)) / 2;
elseif isequal(vSort, [18 37 234 244]) % Mean(both above) minus mean(both below)
    VEOG = (x256(18,:) + x256(37,:)) / 2 - (x256(234,:) + x256(244,:)) / 2;
elseif isequal(vSort, [18 234]) % Mean(right above minus right below)
    VEOG = (x256(18,:) - x256(234,:)) / 2;
elseif isequal(vSort, [37 244]) % Mean(left above minus left below)
    VEOG = (x256(37,:) - x256(244,:)) / 2;
elseif nargin == 4
    warning(['User override specifies VEOG electrodes ' mat2str(V) '.'])
    disp('Computing mean of user-override VEOG electrodes...')
    VEOG = mean(x256(V,:), 1);
else
   error([mat2str(V) ' is not an appropriate electrode selection for VEOG computation.']) 
end
disp(['VEOG computed from ' mat2str(V) '.'])

% HEOG computations
hSort = sort(H);
if isequal(hSort, [1 54]) % Mean(upper right minus upper left)
    HEOG = (x256(1,:) - x256(54,:));
elseif isequal(hSort, [226 252]) % Mean(lower right minus lower left)
    HEOG = (x256(226,:) - x256(252,:));
elseif isequal(hSort, [1 54 226 252]) % Mean(both right) - mean(both left)
    HEOG = (x256(1,:) + x256(226,:)) / 2 - (x256(54,:) + x256(252,:)) / 2;
elseif nargin == 4
    warning(['User override specifies HEOG electrodes ' mat2str(H) '.'])
    disp('Computing mean of user-override HEOG electrodes...')
    HEOG = mean(x256(H,:), 1);
else
    error([mat2str(H) ' is not an appropriate electrode selection for HEOG computation.'])
end
disp(['HEOG computed from ' mat2str(H) '.'])


% Make sure they are columns
VEOG = VEOG(:);
HEOG = HEOG(:);