% createMapIndicatorMatricesFrom129.m
% ------------------------------------
% Blair - May 22, 2018
%
% This script creates the indicator matrices for the 124-127 electrode
% montages.

% Adapted from createMapIndicatorMatricesFrom257.m Blair - Dec 20, 2017

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

saveMat = 1;

%%% 126/127 montages
% Column 1: Numbers 1:129
mapIndicator127(:,1) = 1:129; 
% Column 3: Indicators (1 or 0)
mapIndicator127(:,3) = 1; % Start with all = 1
mapIndicator127(126:127,3) = 0; % Set 126, 127 = 0
% Column 2: Numbers 1:127
mapIndicator127(mapIndicator127(:,3)==1,2) = 1:127;
% Rm last row for 126 montage
mapIndicator126 = mapIndicator127(1:(end-1),:);
sum(mapIndicator126(:,3))
if saveMat
   save mapIndicator127.mat mapIndicator127
   save mapIndicator126.mat mapIndicator126
end

clearvars -except saveMat

%%% 124/125 montages
% Column 1: Numbers 1:129
mapIndicator125(:,1) = 1:129;
% Column 3: Indicators (1 or 0)
mapIndicator125(:,3) = 1;
mapIndicator125(125:128,3) = 0;
% Column 2: Numbers 1:125
mapIndicator125(mapIndicator125(:,3)==1,2) = 1:125;
% Rm last row for 124 montage
mapIndicator124 = mapIndicator125(1:(end-1),:);
sum(mapIndicator124(:,3))
if saveMat
   save mapIndicator125.mat mapIndicator125
   save mapIndicator124.mat mapIndicator124
end



