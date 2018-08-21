function tempo2_plotTempoLines(tempoVector, labels)
% tempo2_plotTempoLines(tempoVector, [labels])
% ----------------------------------------------
% Blair - March 19, 2017
% This function takes in a vector of tempos and optional vector of labels,
% and adds them to an EXISTING plot. You should hold on prior to calling
% this function. Color palette is loaded and called within this function.
% If no 'labels' vector is supplied, the function supplies one, starting
% with 1/2x tempo.
%
% Developed for Tempo2 plots. 

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

load colors.mat
yl = get(gca, 'ylim');

allLabels = {'1/2x Tempo', 'Tempo', '2x Tempo', '4x Tempo', '8x Tempo', '16x Tempo'};
if nargin < 2
    labels = allLabels(1:length(tempoVector));
end

for i = 1:length(tempoVector)
    currCol = rgb10(i,:);
    plot([tempoVector(i) tempoVector(i)], yl, '--', 'linewidth', 1,...
        'color', grayCol)
    t = text(tempoVector(i), yl(2) * .9, labels{i}, 'fontweight', 'bold',...
        'horizontalalignment', 'right', 'fontsize', 12, 'rotation', 90,...
        'verticalalignment', 'bottom');
end