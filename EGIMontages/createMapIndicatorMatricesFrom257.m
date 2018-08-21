% createMapIndicatorMatricesFrom257.m
% ------------------------------------
% Blair - Dec 20, 2017
%
% This script creates the indicator matrices for the 212/213 and 194/195
% reduced montages. 

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

saveMat = 1;

%%% 213/212 montages
% Column 1: Numbers 1:257
mapIndicator213(:,1) = 1:257; 
% Column 3: Indicators (1 or 0)
mapIndicator213(:,3) = 1;
load exclude256to212.mat
mapIndicator213(exclude256to212,3) = 0;
% Column 2: Numbers 1:213
mapIndicator213(mapIndicator213(:,3)==1,2) = 1:213;
% Rm last row for 212 montage
mapIndicator212 = mapIndicator213(1:(end-1),:);
sum(mapIndicator212(:,3))
if saveMat
   save mapIndicator213.mat mapIndicator213
   save mapIndicator212.mat mapIndicator212
end

clearvars -except saveMat

%%% 195/194 montages
% Column 1: Numbers 1:257
mapIndicator195(:,1) = 1:257;
% Column 3: Indicators (1 or 0)
mapIndicator195(:,3) = 1;
load exclude256to194.mat
mapIndicator195(exclude256to194,3) = 0;
% Column 2: Numbers 1:195
mapIndicator195(mapIndicator195(:,3)==1,2) = 1:195;
% Rm last row for 194 montage
mapIndicator194 = mapIndicator195(1:(end-1),:);
sum(mapIndicator194(:,3))
if saveMat
   save mapIndicator195.mat mapIndicator195
   save mapIndicator194.mat mapIndicator194
end



