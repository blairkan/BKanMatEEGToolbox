function [V, H] = getEOGAssignments128()
% [V, H] = getEOGAssignments128()
% ---------------------------------------------------
% Blair - May 18, 2018
%
% This function opens dialog boxes to request and get input from the user
% on assignment of VEOG and HEOG electrode numbers. 
%
% Request 1: VEOG
% - User can leave blank to use default assignment [8 25] (upper only)
% Request 2: HEOG
% - User can leave blank to use default assignment [1 125 32 128] (all)

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

% Adapted from [V, H] = getEOGAssignments256() Blair - Jan 26, 2018

temp = (inputdlg(sprintf('Enter VEOG electrodes as space-separated numbers:\n(Leave blank to use default [8 25])')));
V = sort(str2double(temp{:}));
if isempty(V), V = [8 25]; end

temp = (inputdlg(sprintf('Enter HEOG electrodes as space-separated numbers:\n(Leave blank to use default [1 125 32 128])')));
H = sort(str2double(temp{:}));
if isempty(H), H = [1 125 32 128]; end