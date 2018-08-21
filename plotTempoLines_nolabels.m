function t = plotTempoLines_nolabels(tempoVector, linewidth, linetype)
% t = plotTempoLines_nolabels(tempoVector, [linewidth], [linetype])
% ----------------------------------------------------------
% Blair - April 14, 2017
% Adapted from tempo2_plotTempoLines(tempoVector, [labels])
% Blair - Feb. 2017
%
% This function takes in a vector of tempos and optional linewidth and 
% linetype args, and adds them to an EXISTING plot. You should hold on 
% prior to calling this function. Color palette is loaded and called 
% within this function.
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
if ~exist('linewidth'), linewidth = 1; end
if ~exist('linetype'), linetype = '--'; end

for i = 1:length(tempoVector)
    currCol = rgb10(i,:);
    t(i) = plot([tempoVector(i) tempoVector(i)], yl, linetype,...
        'linewidth', linewidth,...
        'color', currCol);
end