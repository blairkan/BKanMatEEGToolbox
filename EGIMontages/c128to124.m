function e124 = c128to124(e128, optionalShow)
% e124 = c128to124(e128, optionalShow)
% --------------------------------------
% Blair - 24 May 2018
%
% This function converts an electrode number from the 128-electrode montage
% to its respective number in the 124-electrode montage. Returns a warning
% if the input electrode number is out of range, or is not included in the
% 124-electrode montage. Should work with scalar or vector input.

% Adapted from e213 = c257to213(e257, optionalShow) Blair - 22 Dec 2017

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

% e128 = [1:3 124:128] % dev
% optionalShow=1;


if nargin < 2
    optionalShow = 0;
end

if any(e128 > 128 | e128 < 1)
    error(['Input ' mat2str(e128) ' contains electrode number out of range.'])
end

load mapIndicator124

% Col 1 is 128, Col 2 is 124, and we have verified that e128 is in range
e124 = mapIndicator124(e128, 2); e124 = e124(:);

if any(e124 == 0)
    warning(['Input electrode(s) ' mat2str(e128(e124==0)) ' not used in 124-channel montage.'])
end

if optionalShow
   disp('c128to124 mappings')
   disp([e128(:) e124(:)])
end