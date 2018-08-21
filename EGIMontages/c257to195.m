function e195 = c257to195(e257, optionalShow)
% e195 = c257to195(e257, optionalShow)
% --------------------------------------
% Blair - 22 Dec 2017
%
% This function converts an electrode number from the 257-electrode montage
% to its respective number in the 195-electrode montage. Returns a warning
% if the input electrode number is out of range, or is not included in the
% 195-electrode montage. Should work with scalar or vector input.

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

% e257 = [1 257 212 256] % dev

if nargin < 2
    optionalShow = 0;
end

if any(e257 > 257 | e257 < 1)
    error(['Input ' mat2str(e257) ' contains electrode number out of range.'])
end

load mapIndicator195
% C1 is 257, C2 is 195, and we have verified that e257 is in range
e195 = mapIndicator195(e257, 2); e195 = e195(:);

if any(e195 == 0)
    warning(['Input electrode(s) ' mat2str(e257(e195==0)) ' not used in 195 montage.'])
end

if optionalShow
   disp('c257to195 mappings')
   disp([e257(:) e195(:)])
end