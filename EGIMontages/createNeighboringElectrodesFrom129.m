% createNeighboringElectrodesFrom129.m
% ------------------------------------
% Blair - May 21, 2018
%
% This script contains the neighboring assignment electrodes for the full
% 129-channel montage, and from there generates all the
% neighboringElectrodes###.mat files for full and reduced electrode
% montages related to the 128/129-channel system. This is intended to serve
% as the only place where the neighboring electrodes need to be written
% out, to minimize typing errors and centralize edits/updates.

% Adapted from createNeighboringElectrodesFrom257.m Blair - Jan 10, 2018
% based off the montage stored in the previous version of
% neighboringElectrodes125.mat.

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

ccc
outDir = '/usr/ccrma/media/projects/jordan/Analysis/misc/EGIMontages';
saveOut = 1;

NEIGHBORS = cell(129,1); % Initialize as full 129-channel montage

% Now the fun part
NEIGHBORS{1} = [8 2 122 121 125];
NEIGHBORS{2} = [1 8 9 3 123 122];
NEIGHBORS{3} = [2 9 10 4 124 123];
NEIGHBORS{4} = [3 10 11 5 118 124];
NEIGHBORS{5} = [4 11 12 6 112 118];
NEIGHBORS{6} = [5 12 13 7 106 112];
NEIGHBORS{7} = [6 13 30 31 129 106];
NEIGHBORS{8} = [1 2 9 14];
NEIGHBORS{9} = [2 8 14 15 10 3];
NEIGHBORS{10} = [9 15 16 11 4 3];
NEIGHBORS{11} = [10 16 18 19 12 5 4];
NEIGHBORS{12} = [11 19 20 13 6 5];
NEIGHBORS{13} = [12 20 29 30 7 6];
NEIGHBORS{14} = [8 9 15 17]; % BK: Rm #21 20180521
NEIGHBORS{15} = [14 17 21 22 18 16 10 9];
NEIGHBORS{16} = [15 18 11 10];
NEIGHBORS{17} = [14 21 15];
NEIGHBORS{18} = [15 22 23 19 11 16];
NEIGHBORS{19} = [18 23 24 20 12 11];
NEIGHBORS{20} = [19 24 28 29 13 12];
NEIGHBORS{21} = [15 17 25 22]; % BK: Rm #14 20180521
NEIGHBORS{22} = [21 25 26 23 18 15];
NEIGHBORS{23} = [22 26 27 24 19 18];
NEIGHBORS{24} = [23 27 28 20 19];
NEIGHBORS{25} = [21 32 26 22];
NEIGHBORS{26} = [25 32 33 27 23 22];
NEIGHBORS{27} = [26 33 34 28 24 23];
NEIGHBORS{28} = [27 34 35 29 20 24];
NEIGHBORS{29} = [28 35 36 30 13 20];
NEIGHBORS{30} = [29 36 37 31 7 13];
NEIGHBORS{31} = [30 37 54 55 129 7];
NEIGHBORS{32} = [128 38 33 26 25];
NEIGHBORS{33} = [32 38 39 34 27 26]; % BK: Fixed #23 --> #32 20180521
NEIGHBORS{34} = [33 39 40 35 28 27];
NEIGHBORS{35} = [34 40 41 36 29 28];
NEIGHBORS{36} = [35 41 42 37 30 29];
NEIGHBORS{37} = [36 42 53 54 31 30];
NEIGHBORS{38} = [32 128 43 44 39 33];
NEIGHBORS{39} = [38 44 45 40 34 33];
NEIGHBORS{40} = [39 45 46 41 35 34];
NEIGHBORS{41} = [40 46 47 42 36 35]; % BK: Added #35 20180521
NEIGHBORS{42} = [41 47 52 53 37 36];
NEIGHBORS{43} = [128 38 44 49 48];
NEIGHBORS{44} = [43 49 39 38];
NEIGHBORS{45} = [39 57 50 46 40];
NEIGHBORS{46} = [45 50 51 47 41 40];
NEIGHBORS{47} = [46 51 52 42 41];
NEIGHBORS{48} = [128 43 49];
NEIGHBORS{49} = [48 56 44 43];
NEIGHBORS{50} = [57 64 58 51 46 45]; 
NEIGHBORS{51} = [50 58 59 52 47 46];
NEIGHBORS{52} = [51 59 60 53 42 47];
NEIGHBORS{53} = [52 60 61 54 37 42];
NEIGHBORS{54} = [53 61 55 31 37];
NEIGHBORS{55} = [54 79 80 129 31];
NEIGHBORS{56} = [49 63 57];
NEIGHBORS{57} = [56 63 64 58 50 45]; % BK: Added #50,#58 20180521 (cf #100)
NEIGHBORS{58} = [57 64 65 59 51 50]; % BK: Added #57,#59 20180521 (cf #96)
NEIGHBORS{59} = [58 65 66 60 52 51];
NEIGHBORS{60} = [59 66 67 61 53 52];
NEIGHBORS{61} = [60 67 62 54 53];
NEIGHBORS{62} = [61 67 72 77 78];
NEIGHBORS{63} = [68 64 57 56];
NEIGHBORS{64} = [63 68 69 65 58 50 57];
NEIGHBORS{65} = [64 69 70 66 59 58]; % BK: Added #70 20180521
NEIGHBORS{66} = [65 70 71 67 60 59];
NEIGHBORS{67} = [66 71 72 62 61 60];
NEIGHBORS{68} = [63 73 69 64];
NEIGHBORS{69} = [68 73 74 70 65 64];
NEIGHBORS{70} = [69 74 75 71 66 65];
NEIGHBORS{71} = [70 75 76 72 67 66];
NEIGHBORS{72} = [71 76 77 62 67];
NEIGHBORS{73} = [68 81 74 69];
NEIGHBORS{74} = [73 81 82 75 70 69];
NEIGHBORS{75} = [74 82 83 76 71 70];
NEIGHBORS{76} = [75 83 84 77 72 71];
NEIGHBORS{77} = [72 76 84 85 78 62]; % BK: Added #72 20180521
NEIGHBORS{78} = [77 85 86 79 62];
NEIGHBORS{79} = [78 86 87 80 55];
NEIGHBORS{80} = [79 87 105 106 129 55];
NEIGHBORS{81} = [73 88 82 74];
NEIGHBORS{82} = [81 88 89 83 75 74];
NEIGHBORS{83} = [82 89 90 84 76 75];
NEIGHBORS{84} = [83 90 91 85 77 76];
NEIGHBORS{85} = [84 91 92 86 78 77];
NEIGHBORS{86} = [85 92 93 87 79 78];
NEIGHBORS{87} = [86 93 104 105 80 79];
NEIGHBORS{88} = [94 89 82 81];
NEIGHBORS{89} = [88 94 95 90 83 82];
NEIGHBORS{90} = [89 95 96 91 84 83];
NEIGHBORS{91} = [90 96 97 92 85 84];
NEIGHBORS{92} = [91 97 98 93 86 85];
NEIGHBORS{93} = [92 98 103 104 87 86];
NEIGHBORS{94} = [88 99 95 89];
NEIGHBORS{95} = [94 99 100 101 96 90 89];
NEIGHBORS{96} = [95 100 101 97 91 90]; % BK: Added #100 20180521 (cf #58)
NEIGHBORS{97} = [96 101 102 98 92 91];
NEIGHBORS{98} = [97 102 103 93 92];
NEIGHBORS{99} = [94 95 100 107];
NEIGHBORS{100} = [99 107 108 101 96 95];% BK: Added #96 20180521 (cf #58)
NEIGHBORS{101} = [100 108 102 97 96 95];
NEIGHBORS{102} = [101 108 109 103 98 97];
NEIGHBORS{103} = [102 109 110 104 93 98];
NEIGHBORS{104} = [103 110 111 105 87 93];
NEIGHBORS{105} = [104 111 112 106 80 87];
NEIGHBORS{106} = [105 112 6 7 129 80];
NEIGHBORS{107} = [99 113 100];
NEIGHBORS{108} = [100 101 102 109 115];
NEIGHBORS{109} = [108 115 116 110 103 102];
NEIGHBORS{110} = [109 116 117 111 104 103];
NEIGHBORS{111} = [110 117 118 112 105 104];
NEIGHBORS{112} = [111 118 5 6 106 105];
NEIGHBORS{113} = [107 114 119 120];
NEIGHBORS{114} = [115 121 120 113]; % BK: Rm #122 20180521
NEIGHBORS{115} = [114 121 122 116 109 108];
NEIGHBORS{116} = [115 122 123 117 110 109];
NEIGHBORS{117} = [116 123 124 118 111 110];
NEIGHBORS{118} = [117 124 4 5 112 111];
NEIGHBORS{119} = [113 120 125];
NEIGHBORS{120} = [113 114 121 125 119];
NEIGHBORS{121} = [120 125 1 122 115 114];
NEIGHBORS{122} = [121 1 2 123 116 115];
NEIGHBORS{123} = [122 2 3 124 117 116];
NEIGHBORS{124} = [123 3 4 118 117];
NEIGHBORS{125} = [119 120 121 1];
NEIGHBORS{126} = [125 1 8]; % Not a good electrode to interpolate.
NEIGHBORS{127} = [128 32 25]; % Not a good electrode to interpolate.
NEIGHBORS{128} = [48 43 38 32]; 
NEIGHBORS{129} = [80 106 7 31 55];

%% 129 electrodes

neighbors = NEIGHBORS;

% We don't need to exclude cell entries or elements in cell entries. We
% also don't need to re-assign electrode numbers. So we'll just convert
% each entry to a column for consistency with other outputs. 
for i = 1:length(neighbors)
   neighbors{i} = neighbors{i}(:); % Convert each entry to column 
end

if saveOut, cd(outDir); save neighboringElectrodes129.mat neighbors
end

%% 128 electrodes

neighbors = NEIGHBORS;

% 0 - Electrode(s) to remove
rm129to128 = [129]; 

% 1 - Remove exluded electrodes from cell array
neighbors(rm129to128) = []; % Remove cell array element 129.

% 2 - Go through remaining electrodes and remove mention of excluded 
% electrodes from each array in the cell array
for i = 1:length(neighbors)
   neighbors{i}(ismember(neighbors{i}, rm129to128)) = []; 
   
   % 3 - Ensure each element is a column vector
   neighbors{i} = neighbors{i}(:);
   
      
   % 4 - No need to do electrode renumbering
end

if saveOut, cd(outDir); save neighboringElectrodes128.mat neighbors
end

%% 127 electrodes

neighbors = NEIGHBORS;

% 0 - Electrodes to remove. Here we remove the two cheek electrodes. 
rm129to127 = [126 127];

% 1 - Remove above elements from the cell array
neighbors(rm129to127) = [];

% For remaining cell array elements...
for i = 1:length(neighbors)
    
   % 2 - Remove excluded electrodes from each cell array element
   neighbors{i}(ismember(neighbors{i}, rm129to127)) = [];
   
   % 3 - Convert each element to column vector
   neighbors{i} = neighbors{i}(:);
   
   % 4 - Renumber the remaining electrodes so numbers go from 1:127
   neighbors{i} = c129to127(neighbors{i});
end
clear rm129*

if saveOut, cd(outDir); save neighboringElectrodes127.mat neighbors
end

%% 126 electrodes

neighbors = NEIGHBORS;

% 0 - Electrodes to remove. Here we remove the cheek electrodes and ref. 
rm129to126 = [126 127 129];

% 1 - Remove above elements from the cell array
neighbors(rm129to126) = [];

% For remaining cell array elements...
for i = 1:length(neighbors)
    
   % 2 - Remove excluded electrodes from each cell array element
   neighbors{i}(ismember(neighbors{i}, rm129to126)) = [];
   
   % 3 - Convert each element to column vector
   neighbors{i} = neighbors{i}(:);
   
   % 4 - Renumber the remaining electrodes so numbers go from 1:126
   neighbors{i} = c128to126(neighbors{i});
end
clear rm129*

if saveOut, cd(outDir); save neighboringElectrodes126.mat neighbors
end

%% 125 electrodes

neighbors = NEIGHBORS;

% 0 - Electrodes to remove. Here we remove the four face electrodes
rm129to125 = [125:128];

% 1 - Remove above elements from the cell array
neighbors(rm129to125) = [];

% For remaining cell array elements...
for i = 1:length(neighbors)
    
   % 2 - Remove excluded electrodes from each cell array element
   neighbors{i}(ismember(neighbors{i}, rm129to125)) = [];
   
   % 3 - Convert each element to column vector
   neighbors{i} = neighbors{i}(:);
   
   % 4 - Renumber the remaining electrodes so numbers go from 1:125
   neighbors{i} = c129to125(neighbors{i});
end
clear rm129*

if saveOut, cd(outDir); save neighboringElectrodes125.mat neighbors
end

%% 124 electrodes

neighbors = NEIGHBORS;

% 0 - Electrodes to remove. Here we remove face electrodes + ref. 
rm129to124 = [125:129];

% 1 - Remove above elements from the cell array
neighbors(rm129to124) = [];

% For remaining cell array elements...
for i = 1:length(neighbors)
    
   % 2 - Remove excluded electrodes from each cell array element
   neighbors{i}(ismember(neighbors{i}, rm129to124)) = [];
   
   % 3 - Convert each element to column vector
   neighbors{i} = neighbors{i}(:);
   
   % 4 - Renumber the remaining electrodes so numbers go from 1:124
   neighbors{i} = c128to124(neighbors{i});
end
clear rm129*

if saveOut, cd(outDir); save neighboringElectrodes124.mat neighbors
end