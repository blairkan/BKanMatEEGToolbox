function plotCorrEOG(corrV, corrH, tStr)
% plotCorrEOG(corrV, corrH, [tStr])
% ---------------------------------
% Blair - May 8, 2014
% Plot ICA source correlations with VEOG and HEOG channels.

% Function history
% - 2/19/2025: Add optional title
% - 2/5/2025: Copied from https://github.com/blairkan/BKanMatEEGToolbox

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2014 Blair Kaneshiro
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

figure('name', 'EOG Correlation Coefficients', 'numbertitle', 'off')
for i = 1:length(corrV)
   text(corrH(i), corrV(i), num2str(i), 'FontSize', 20, 'linewidth', 3, ...
       'horizontalAlignment', 'center', 'verticalAlignment', 'middle')
end
grid on
xlim([-1 1])
ylim([-1 1])
xlabel('HEOG', 'FontSize', 20, 'linewidth', 3)
ylabel('VEOG', 'FontSize', 20, 'linewidth', 3)

if nargin == 3
    title(tStr, 'interpreter', 'none', 'fontsize', 20); 
end