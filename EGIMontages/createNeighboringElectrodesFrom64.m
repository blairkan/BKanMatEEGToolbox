% createNeighboringElectrodesFrom64.m
% ------------------------------------
% Blair / Mathieu - December 4, 2020
%
% This script contains the neighboring assignment electrodes for the
% BioSemi 64-channel montage, and from there generates the
% neighboringElectrodes64.mat file. This is intended to serve
% as the only place where the neighboring electrodes need to be written
% out, to minimize typing errors and centralize edits/updates.

% Adapted from createNeighboringElectrodesFrom129.m Blair - May 21, 2018

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2020 Blair Kaneshiro
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

clear all; close all; clc
outDir = '.';
saveOut = 1;

NEIGHBORS = cell(64, 1) ;

NEIGHBORS{1} = [ 2, 3, 33 ] ;
NEIGHBORS{2} = [ 1, 3, 7 ] ;
NEIGHBORS{3} = [ 1, 2, 5 ] ;
NEIGHBORS{4} = [ 5, 11, 38 ] ;
NEIGHBORS{5} = [ 3, 4, 6 ] ;
NEIGHBORS{6} = [ 5, 7, 9 ] ;
NEIGHBORS{7} = [ 2, 6, 8 ] ;
NEIGHBORS{8} = [ 7, 9, 15 ] ;
NEIGHBORS{9} = [ 6, 8, 14 ] ;
NEIGHBORS{10} = [ 5, 11, 13 ] ;
NEIGHBORS{11} = [ 10, 12, 47 ] ;
NEIGHBORS{12} = [ 11, 19, 48 ] ;
NEIGHBORS{13} = [ 10, 14, 18 ] ;
NEIGHBORS{14} = [ 9, 13, 17 ] ;
NEIGHBORS{15} = [ 8, 14, 16 ] ;
NEIGHBORS{16} = [ 15, 17, 23 ] ;
NEIGHBORS{17} = [ 14, 16, 22 ] ;
NEIGHBORS{18} = [ 13, 19, 21 ] ;
NEIGHBORS{19} = [ 12, 18, 32 ] ;
NEIGHBORS{20} = [ 19, 21, 31 ] ;
NEIGHBORS{21} = [ 20, 22, 26 ] ;
NEIGHBORS{22} = [ 17, 21, 23 ] ;
NEIGHBORS{23} = [ 16, 22, 25 ] ;
NEIGHBORS{24} = [ 16, 23, 25 ] ;
NEIGHBORS{25} = [ 23, 26, 27 ] ;
NEIGHBORS{26} = [ 21, 25, 27 ] ;
NEIGHBORS{27} = [ 25, 26, 29 ] ;
NEIGHBORS{28} = [ 27, 29, 64 ] ;
NEIGHBORS{29} = [ 27, 30, 64 ] ;
NEIGHBORS{30} = [ 29, 31, 63 ] ;
NEIGHBORS{31} = [ 20, 32, 57 ] ;
NEIGHBORS{32} = [ 19, 31, 56 ] ;
NEIGHBORS{33} = [ 1, 34, 37 ] ;
NEIGHBORS{34} = [ 33, 35, 36 ] ;
NEIGHBORS{35} = [ 34, 36, 42 ] ;
NEIGHBORS{36} = [ 34, 35, 40 ] ;
NEIGHBORS{37} = [ 33, 38, 3 ] ;
NEIGHBORS{38} = [ 39, 47, 4 ] ;
NEIGHBORS{39} = [ 38, 40, 46 ] ;
NEIGHBORS{40} = [ 36, 39, 41 ] ;
NEIGHBORS{41} = [ 40, 42, 44 ] ;
NEIGHBORS{42} = [ 35, 41, 43 ] ;
NEIGHBORS{43} = [ 42, 44, 52 ] ;
NEIGHBORS{44} = [ 41, 43, 51 ] ;
NEIGHBORS{45} = [ 40, 46, 50 ] ;
NEIGHBORS{46} = [ 45, 47, 49 ] ;
NEIGHBORS{47} = [ 46, 38, 11 ] ;
NEIGHBORS{48} = [ 47, 49, 12 ] ;
NEIGHBORS{49} = [ 46, 48, 56 ] ;
NEIGHBORS{50} = [ 45, 51, 55 ] ;
NEIGHBORS{51} = [ 44, 50, 54 ] ;
NEIGHBORS{52} = [ 43, 51, 53 ] ;
NEIGHBORS{53} = [ 52, 54, 60 ] ;
NEIGHBORS{54} = [ 51, 53, 59 ] ;
NEIGHBORS{55} = [ 50, 56, 58 ] ;
NEIGHBORS{56} = [ 49, 55, 32 ] ;
NEIGHBORS{57} = [ 56, 58, 31 ] ;
NEIGHBORS{58} = [ 57, 59, 63 ] ;
NEIGHBORS{59} = [ 54, 58, 60 ] ;
NEIGHBORS{60} = [ 53, 59, 62 ] ;
NEIGHBORS{61} = [ 53, 60, 62 ] ;
NEIGHBORS{62} = [ 60, 63, 64 ] ;
NEIGHBORS{63} = [ 58, 62, 64 ] ;
NEIGHBORS{64} = [ 62, 63, 29 ] ;

%% Write it out

neighbors = NEIGHBORS;

% We don't need to exclude cell entries or elements in cell entries. We
% also don't need to re-assign electrode numbers. So we'll just convert
% each entry to a column for consistency with other outputs. 
for i = 1:length(neighbors)
   neighbors{i} = neighbors{i}(:); % Convert each entry to column 
end

if saveOut, cd(outDir); save neighboringElectrodes64.mat neighbors
end