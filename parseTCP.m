function [allTriggers, allOnsets] = parseTCP(tcpip)

% [allTriggers, allOnsets] = parseTCP(tcpip)
% -------------------------------------------
% Blair - Nov 15, 2017
% Adapted from [allTriggers, allOnsets] = parseDIN(DIN_1) Blair May 6 2014
% Takes in the evt_ECI_TCPIP_55513 variable and returns two vectors. 
% First vector is all trigger labels (as integers); second vector is all 
% onsets at the original sampling rate (usually 1 kHz). Both returned
% values are in column vectors.
%
% See also parseDIN

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

% The structure of the input variable is as follows:
% - It's a cell array of size 4 x nTriggers
% - Row 1 contains the triggers (strings)
% - Row 2 contains the onset times (probably in msec)
% - Row 3 is something (all 1's right now)
% - Row 4 contains the onset times (probably in samples). When the data are
%   exported with no downsampling, this row is the same as row 2. We have
%   found in the past (with the DIN matrix) that when data are exported
%   WITH downsampling, this row is floor(row2/D), so it's better to compute
%   the downsampled onset times by hand from row 2, e.g., round(row2/D).

% Get all the triggers from the first row of TCP
allTriggers = str2double(tcpip(1,:)); 

% Get all onsets from second row of TCP
allOnsets = cell2mat(tcpip(2,:));

allTriggers = allTriggers(:); allOnsets = allOnsets(:);