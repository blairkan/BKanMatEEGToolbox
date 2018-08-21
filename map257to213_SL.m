% map257to213.m
% Steven and Blair - Jan 18, 2017

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

clear all; close all; clc

chans257 = 1:257; chans257 = chans257(:);
chans257_rm = chans257;

chans257_rm([67 73 82 91 92 102 208 209 216:219 225:256]) = 0;
idxKeep = find(chans257_rm > 0);

chans213 = chans257_rm;
chans213(idxKeep) = 1:213;

CHANS = [chans257 chans213]; % <-- this is the mapping matrix
%%
load neighbors213w257elements.mat

neighbors213 = {};

for i = 1:257
   if ~isempty(neighbors{i})
      electrodeIn = i;
      electrodeOut = CHANS(i,2);
      disp(['Electrode ' num2str(electrodeIn) ' becomes '...
          num2str(electrodeOut)])
      neighbors213{electrodeOut} = CHANS(neighbors{electrodeIn}, 2);
   end
end

%% Sanity check 
close all
elecPlot = 120;

neighborsPlot = neighbors213{elecPlot};
plotVec = zeros(213,1);
plotVec(elecPlot) = 1;
plotVec(neighborsPlot) = 0.5;

ll = getLocs213;

topoplot(plotVec, ll, 'electrodes', 'on')

%% Save the ouptut

save neighbors213.mat neighbors213
