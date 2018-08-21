function e125 = c129to125(e129, optionalShow)
% e125 = c129to125(e129, optionalShow)
% --------------------------------------
% Blair - 24 May 2018
%
% This function converts an electrode number from the 129-electrode montage
% to its respective number in the 125-electrode montage. Returns a warning
% if the input electrode number is out of range, or is not included in the
% 125-electrode montage. Should work with scalar or vector input.

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

% e129 = [1:3 124:129] % dev
% optionalShow=1;


if nargin < 2
    optionalShow = 0;
end

if any(e129 > 129 | e129 < 1)
    error(['Input ' mat2str(e129) ' contains electrode number out of range.'])
end

load mapIndicator125

% Col 1 is 129, Col 2 is 125, and we have verified that e129 is in range
e125 = mapIndicator125(e129, 2); e125 = e125(:);

if any(e125 == 0)
    warning(['Input electrode(s) ' mat2str(e129(e125==0)) ' not used in 125-channel montage.'])
end

if optionalShow
   disp('c129to125 mappings')
   disp([e129(:) e125(:)])
end