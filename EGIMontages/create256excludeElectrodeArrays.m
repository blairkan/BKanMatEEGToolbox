% create256excludeElectrodeArrays.m
% ----------------------------------
% Blair - Dec 18, 2017
%
% Specify the arrays for which electrodes to exclude when reducing from
% full 256/257 montage to 212/213 (exclude cheek) and from 256/257 to
% 194/195 (exclude cheek and neck).

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

ccc

% Remove cheek electrodes to reduce from 256 to 212
exclude256to212 = [67 73 82 91 92 102 208 209 216:219 225:256];
exclude256to212 = exclude256to212(:);

% Remove neck electrodes to reduce from 212 to 194
exclude212to194 = [103 111 112 120 121 133 134 145 146 ...
    156 165 166 174 175 187 188 199 200];
exclude212to194 = exclude212to194(:);

% Combine to reduce from 256 to 194
exclude256to194 = sort([exclude256to212; exclude212to194]);
%%
save exclude256to212.mat exclude256to212
save exclude212to194.mat exclude212to194
save exclude256to194.mat exclude256to194