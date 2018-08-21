function buildSongAssignment
% buildSongAssignment
% --------------------------
% Duc - March 1, 2016

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

%change this accordingly
inDir = '/usr/ccrma/media/jordan/Experiments/Eng1.2/SongStructsV2d_softICAThresh_48subs';
outDir = '/usr/ccrma/media/jordan/Experiments/Eng1.2/BehavOutV2d_softICAThresh';


postfix = {'_a', '_b'};

for k=1:2
    
    cd(inDir)
    
    for i=1:16 %this loops through all subject in the folder and will run through sub_a.mat that works
        %%%%%%%%%%% Enter the subject number you want to process %%%%%%%%%%%
        currSub = sprintf('song%d',i+20);    %
        load([currSub postfix{k}])
    end
    
    for i=1:16
        song=sprintf('subs%d',i+20);
        eval(['songAssignment(i,:) = ' song postfix{k} '(:)'';'])
        display(sprintf('\n%s%s is done.', song, postfix{k}));
    end
    
    cd(outDir)
    eval(['save songAssignment' postfix{k} '.mat songAssignment'])
    display(sprintf('\nThe songAssignment%s is done.', postfix{k}));
    clearvars -except postfix inDir outDir k
    
end