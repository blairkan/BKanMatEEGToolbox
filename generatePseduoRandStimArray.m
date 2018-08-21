function A = generatePseduoRandStimArray(stimVector, nBlocks, randInBlocks)
% A = generatePseudoRandStimArray(stimVector, nBlocks, randInBlocks)
% ----------------------------------------------------------------------
% Blair - June 18, 2018
%
% This function creates a pseudorandomized stim ordering array, in the
% sense that no stimulus is presented twice in a row, but the elements are
% otherwise in random order.
%
% Inputs:
% - stimVector (required): Vector of stimulus labels (triggers). Repeated 
%   elements will be ignored.
% - nBlocks (required) : How many times to present each stimulus.
% - randInBlocks (optional): Whether to randomize the stimulus ordering in 
%   blocks. If true, will randomize the elements of stims, and then 
%   randomize again, ensuring that the last element of one block is not 
%   equal to the first element of the next block. If false, will create a 
%   single vector of all the instances of the stimuli, and randomize that. 
%   If not specified, will default to FALSE.
%
% Outputs:
% - A: The randomized stimulus array. Its length will be length(stims)
%   times nBlocks.

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

rng('shuffle')

%%%%%%%% Uncomment for dev %%%%%%%
% stims = 21:23; nBlocks = 11; randInBlocks = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3 
    disp('Input ''randInBlocks'' not specified; setting to 0.')
    randInBlocks = 0; 
end

stimVector = sort(unique(stimVector)); stimVector = stimVector(:);
nStims = length(stimVector);
totalNStims = nStims * nBlocks;
A = nan(totalNStims, 1);

if randInBlocks     % Randomize block by block
    disp('Randomizing in blocks.');
    thisPerm = stimVector(randperm(nStims));
    A(1:nStims) = thisPerm;
    thisEnd = thisPerm(end);
    
    for bl = 2:nBlocks
        tryAgain = 1;
        while tryAgain
            thisPerm = stimVector(randperm(nStims));
            if thisPerm(1) ~= thisEnd
                disp(['Block ' num2str(bl) ' successful.'])
                thisEnd = thisPerm(end);
                A((bl-1)*nStims + (1:nStims)) = thisPerm;
                tryAgain = 0;
            else
                disp(['Repeated element. Trying again.']);
            end
        end
    end
    
    
else            % Randomize all the stimuli at once
    disp('Randomizing all stimuli at once.')
    allStims = repmat(stimVector, nBlocks, 1);
    A = allStims(randperm(totalNStims));
    
    for i = 2:totalNStims
%         i
        while A(i) == A(i-1)
            if i == totalNStims
                error('Last two elements repeat! Exiting.')
%                 break;
            else
                remainingStims = A(i:end);
                if length(unique(remainingStims))==1 & unique(remainingStims) == A(i)
                   error('Remaining elements are all repetitions! Exiting.') 
                end
                A(i:end) = remainingStims(randperm(length(remainingStims)));
            end
        end
        
    end
end
[A [NaN;diff(A)]]

% Final sanity check - make sure no two adjacent elements repeat
if any(diff(A)==0), 
    error('Repeated elements after radomization! Something went wrong.'); end