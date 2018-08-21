function Behav = getBehavResults(triggers, nTrials, header)

% Behav = getBehavResults(triggers, nTrials, header)
% --------------------------------------------------------
% Blair
% August 24, 2015
%
% This function takes in the vector of participant rankings (with optional
% stimulus labels) and reshapes into a question x trial matrix, with added 
% header row with trial numbers if specified. 
%
% Inputs
%   - triggers: Array of ratings with optional stimulus labels
%   - nQuestions: How many questions were asked per stimulus
%   - header: Enter 1 if stimulus labels included (and will serve as row
%   headers). Default = 1
%
% The output struct has two fields: One is a matrix
% of the absolute ratings, and the other is a matrix of ranked ratings,
% where rankings are performed one question at a time, across all stimuli.

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

if nargin == 2
   disp('Function note: Assuming header row')
end

if header == 0
    iStart = 1;
else
    iStart = 2;
end

triggers = triggers(:)'; % Make sure it's a row vector
Behav.abs = reshape(triggers, [], nTrials);
Behav.rank = Behav.abs;
for i = iStart:size(Behav.rank,1)
   Behav.rank(i,:) = tiedrank(Behav.rank(i,:)); 
end


