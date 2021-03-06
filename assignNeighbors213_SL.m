% neighboring electrodes 213
% Steven Losorelli & Blair Kaneshiro
% 1.10.17

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2017 Steven Losorelli and Blair Kaneshiro
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

%% neighbors213

ccc
neighbors{1} = [2 10 220 221];
neighbors{2} = [1 3 10 11 221 222];
neighbors{3} = [2 4 11 12 222 223];
neighbors{4} = [3 5 12 13 223 224];
neighbors{5} = [4 6 13 14 215 224];
neighbors{6} = [5 7 14 15 207 215];
neighbors{7} = [6 8 15 16 198 207];
neighbors{8} = [7 9 16 17 186 198];
neighbors{9} = [257 8 17 44 45 186];
neighbors{10} = [1 2 11 18];
neighbors{11} = [2 3 10 12 18 19];
neighbors{12} = [3 4 11 13 19 20];
neighbors{13} = [4 5 12 13 20 21];
neighbors{14} = [5 6 13 15 21 22];
neighbors{15} = [6 7 14 16 22 23];
neighbors{16} = [7 8 15 17 23 24];
neighbors{17} = [8 9 16 44 24 43];
neighbors{18} = [10 11 19 25];
neighbors{19} = [11 12 18 20 25 26];
neighbors{20} = [12 13 19 21 26 27];
neighbors{21} = [13 14 20 21 22 27 28];
neighbors{22} = [14 15 21 23 28 29];
neighbors{23} = [15 16 22 24 29 30];
neighbors{24} = [16 17 23 43 30 42];
neighbors{25} = [18 19 26 31 32];
neighbors{26} = [19 20 25 27 32 33];
neighbors{27} = [20 21 26 28 33 34];
neighbors{28} = [21 22 27 29 34 35];
neighbors{29} = [22 23 28 30 35 36];
neighbors{30} = [23 24 29 42 36 41];
neighbors{31} = [25 32];
neighbors{32} = [25 26 31 33 37];
neighbors{33} = [26 27 32 34 37 38];
neighbors{34} = [27 28 33 35 38 39];
neighbors{35} = [28 29 34 36 39 40];
neighbors{36} = [29 30 35 40 41];
neighbors{37} = [32 33 38 46];
neighbors{38} = [33 34 37 39 46 47];
neighbors{39} = [34 35 38 40 47 48];
neighbors{40} = [35 36 39 41 48 49];
neighbors{41} = [30 36 40 42 49 50];
neighbors{42} = [24 30 41 43 50 51];
neighbors{43} = [17 24 42 44 51 52];
neighbors{44} = [9 17 43 45 52 53];
neighbors{45} = [257 9 18 44 53 80];
neighbors{46} = [37 38 47 54];
neighbors{47} = [38 39 46 48 54];
neighbors{48} = [39 40 47 49 55 56];
neighbors{49} = [40 41 48 50 56 57];
neighbors{50} = [41 42 49 51 57 58];
neighbors{51} = [42 43 50 52 58 59];
neighbors{52} = [43 44 51 53 59 60];
neighbors{53} = [44 45 52 60 79 80];
neighbors{54} = [46 47 55 61];
neighbors{55} = [47 48 54 56 61 62];
neighbors{56} = [48 49 55 57 62 63];
neighbors{57} = [49 50 56 58 63 64];
neighbors{58} = [50 51 57 59 64 65];
neighbors{59} = [51 52 58 60 65 66];
neighbors{60} = [52 53 59 66 78 79];
neighbors{61} = [54 55 62 68];
neighbors{62} = [55 56 61 63 68 69];
neighbors{63} = [56 57 62 64 69 70];
neighbors{64} = [57 58 63 65 70 71];
neighbors{65} = [58 59 64 66 71 72];
neighbors{66} = [59 60 65 78 72 77];
neighbors{68} = [61 62 69];
neighbors{69} = [62 63 68 70 74];
neighbors{70} = [63 64 69 71 74 75];
neighbors{71} = [64 65 70 72 75 76];
neighbors{72} = [65 66 71 76 77];
neighbors{74} = [69 70 75 83 84];
neighbors{75} = [70 71 74 76 84 85];
neighbors{76} = [71 72 75 77 85 86];
neighbors{77} = [72 76 78 86 87];
neighbors{78} = [60 66 77 79 87 88];
neighbors{79} = [53 60 78 80 88 89];
neighbors{80} = [45 53 79 80 89 90];
neighbors{81} = [257 45 80 90 131 132];
neighbors{83} = [74 84 94 95];
neighbors{84} = [74 75 83 85 95 96];
neighbors{85} = [75 76 84 86 96 97];
neighbors{86} = [76 77 85 87 97 98];
neighbors{87} = [77 78 86 88 98 99];
neighbors{88} = [78 79 87 89 99 100];
neighbors{89} = [79 80 88 90 100];
neighbors{90} = [80 81 89 130 131];
neighbors{93} = [94 104];
neighbors{94} = [83 93 95 104 105];
neighbors{95} = [83 84 94 96 105 106];
neighbors{96} = [84 85 95 97 106 107];
neighbors{97} = [85 86 96 98 107 108];
neighbors{98} = [86 87 97 99 108 109];
neighbors{99} = [87 88 98 100 109 110];
neighbors{100} = [88 89 99 101 110];
neighbors{101} = [100 110 119 128 129];
neighbors{103} = [93 104 111 112];
neighbors{104} = [93 94 103 105 112 113];
neighbors{105} = [94 95 104 106 113 114];
neighbors{106} = [95 96 105 107 114 115];
neighbors{107} = [96 97 106 108 115 116];
neighbors{108} = [97 98 107 109 116 117];
neighbors{109} = [98 99 108 110 117 118];
neighbors{110} = [99 100 101 109 118 119];
neighbors{111} = [103 112 120];
neighbors{112} = [103 104 111 113 120 121];
neighbors{113} = [104 105 112 114 121 122];
neighbors{114} = [105 106 113 115 122 123];
neighbors{115} = [106 107 114 116 123 124];
neighbors{116} = [107 108 115 117 124 125];
neighbors{117} = [108 109 116 118 125 126];
neighbors{118} = [109 110 117 119 126 127];
neighbors{119} = [101 110 118 127 128];
neighbors{120} = [111 112 121 133];
neighbors{121} = [112 113 120 122 133 134];
neighbors{122} = [113 114 121 123 134 135];
neighbors{123} = [114 115 122 124 135 136];
neighbors{124} = [115 116 123 125 136 137];
neighbors{125} = [116 117 124 126 137 138];
neighbors{126} = [117 118 125 127 138 139];
neighbors{127} = [118 119 126 128 139 140];
neighbors{128} = [101 119 127 129 140 141];
neighbors{129} = [101 128 130 141 142];
neighbors{130} = [90 129 131 142 143];
neighbors{131} = [81 90 130 132 143 144];
neighbors{132} = [257 81 131 144 185 186];
neighbors{133} = [120 121 134 145];
neighbors{134} = [121 122 133 135 145 146];
neighbors{135} = [122 123 134 136 146 147];
neighbors{136} = [123 124 135 137 147 148];
neighbors{137} = [124 125 136 138 148 149];
neighbors{138} = [125 126 137 139 149 150];
neighbors{139} = [126 127 138 140 150 151];
neighbors{140} = [127 128 139 141 151 152];
neighbors{141} = [128 129 140 142 152 153];
neighbors{142} = [129 130 141 143 153 154];
neighbors{143} = [130 131 142 144 154 155];
neighbors{144} = [131 132 143 155 184 185];
neighbors{145} = [133 144 146];
neighbors{146} = [134 135 145 147 156];
neighbors{147} = [135 136 146 148 156 157];
neighbors{148} = [136 137 147 149 157 158];
neighbors{149} = [137 138 148 150 158 159];
neighbors{150} = [138 139 149 151 159 160];
neighbors{151} = [139 140 150 152 160 161];
neighbors{152} = [140 141 151 153 161 162];
neighbors{153} = [141 142 152 154 162 163];
neighbors{154} = [142 143 153 155 163 164];
neighbors{155} = [143 144 154 164 183 184];
neighbors{156} = [146 147 157 157 165 166];
neighbors{157} = [147 148 156 158 166 167];
neighbors{158} = [148 149 157 159 167 168];
neighbors{159} = [149 150 158 160 168 169];
neighbors{160} = [150 151 159 161 169 170];
neighbors{161} = [151 152 160 162 170 171];
neighbors{162} = [152 153 161 163 171 172];
neighbors{163} = [153 154 162 164 172 173];
neighbors{164} = [154 155 163 173 182 183];
neighbors{165} = [156 166 174];
neighbors{166} = [156 157 165 167 174 175];
neighbors{167} = [157 158 166 168 175 176];
neighbors{168} = [158 159 167 169 176 177];
neighbors{169} = [159 160 168 170 177 178];
neighbors{170} = [160 161 169 171 178 179];
neighbors{171} = [161 162 170 172 179 180];
neighbors{172} = [162 163 171 173 180 181];
neighbors{173} = [163 164 172 181 182];
neighbors{174} = [165 166 175 187];
neighbors{175} = [166 167 174 176 187 188];
neighbors{176} = [167 168 175 177 188 189];
neighbors{177} = [169 170 176 178 189 190];
neighbors{178} = [169 170 177 179 190 191];
neighbors{179} = [170 171 178 180 191 192];
neighbors{180} = [171 172 179 181 192 193];
neighbors{181} = [172 173 180 182 193 194];
neighbors{182} = [164 173 181 183 194 195];
neighbors{183} = [155 164 182 184 195 196];
neighbors{184} = [144 155 183 185 196 197];
neighbors{185} = [132 144 184 186 197 198];
neighbors{186} = [257 8 9 132 185 198];
neighbors{187} = [174 175 188 199];
neighbors{188} = [175 176 187 189 199 200];
neighbors{189} = [176 177 188 190 200 201];
neighbors{190} = [177 178 189 191 201];
neighbors{191} = [178 179 190 192];
neighbors{192} = [179 180 191 193 202];
neighbors{193} = [180 181 192 194 202 203];
neighbors{194} = [181 182 193 195 203 204];
neighbors{195} = [182 183 194 196 204 205];
neighbors{196} = [183 184 195 197 205 206];
neighbors{197} = [184 185 196 198 206 207];
neighbors{198} = [7 8 185 186 197 207];
neighbors{199} = [187 188 200];
neighbors{200} = [188 189 199 201];
neighbors{201} = [189 190 200];
neighbors{202} = [192 193 203 210 211];
neighbors{203} = [193 194 202 204 211 212];
neighbors{204} = [194 195 203 205 212 213];
neighbors{205} = [195 196 204 206 213 214];
neighbors{206} = [196 197 205 207 214 215];
neighbors{207} = [6 7 197 198 206 215];
neighbors{210} = [202 211 220];
neighbors{211} = [202 203 210 212 220 221];
neighbors{212} = [203 204 211 213 221 222];
neighbors{213} = [204 205 212 214 222 223];
neighbors{214} = [205 206 213 215 223 224];
neighbors{215} = [5 6 206 207 214 224];
neighbors{220} = [1 210 211 221];
neighbors{221} = [1 2 211 212 220 222];
neighbors{222} = [2 3 212 213 221 223];
neighbors{223} = [3 4 213 214 222 224];
neighbors{224} = [4 5 214 215 223];
neighbors{257} = [9 45 81 132 186];

%% save

% save neighbors213w257elements.mat neighbors

