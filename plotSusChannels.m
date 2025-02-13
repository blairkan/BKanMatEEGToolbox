function plotSusChannels(fnOut, x129epoched, refChannel, susChannels)
%plotSusChannels(fnOut, x129epoched, refChannel, susChannels)
% --------------------------------------------------------------------
% This function takes in fnOut = which is a string containing subject ID, 
% it also takes the x129epoched raw data and a selected reference channel 
% and a vector of suspicious channels. 

% Function history
% - 12/10/2024: Changed color coding to add transparecy (alpha) e.g. 'b'
%   changed to 'Color', [0 0 1 0.05] where the first three values are the 
%   RGB code and the final value is the alpha value. Color vectors are 
%   hard-coded into the function (not input by user) so there should be no
%   backward compatibility issues. - Philip Hernandez
% - 10/23/2024: Copied to SENSI-EEG-Preproc-CS-private from
%   https://github.com/blairkan/BKanMatEEGToolbox - Blair
% - 3/24/16: Duc

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2016 Duc T. Nguyen
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

figure; hold on;
for i=1:length(susChannels)
    expr=sprintf('subplot %d1%d', length(susChannels), i);
    eval(expr)
    plot(x129epoched(susChannels(i),:), 'Color', [1 0 0 0.1]); hold on; 
    plot(x129epoched(refChannel,:), 'Color', [0 0 1 0.05]); hold on;
    title(sprintf('%s -- refCh: %d in blue; susCh: %d in red', fnOut, refChannel, susChannels(i)), ...
        'interpreter', 'none');
    xlim('tight')
end
