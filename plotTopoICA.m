function plotTopoICA(W, badCh, toPlot)

% plotTopoICA(W, badCh, toPlot)
% ----------------------------
% Blair
% January 27, 2015
% Pass in the ICA matrix W, vector of bad channels, and vector of source
% numbers to plot. Function will plot the projections of selected ICA
% components.
%
% See also multiplotICAResults

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2015 Blair Kaneshiro
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

sfpFn = '/usr/ccrma/media/jordan/Analysis/Hydrocel GSN 128 1.0.sfp';
locs = readlocs(sfpFn);
locs = locs(4:127);

% toPlot = [toPlot; 2];  % FOR TESTING THE FUNCTION
    
% Remove coordinates for bad channels
if length(badCh)>0
    locs(badCh) = [];
end

% Columns of the inverse matrix give projection strengths of respective
% components.
Wi = inv(W);

figure()
for i = 1:length(toPlot)
    subplot (1,length(toPlot),i)
    topoplot(Wi(:,toPlot(i)), locs)
    title([num2str(toPlot(i))], 'fontSize', 16)
end
