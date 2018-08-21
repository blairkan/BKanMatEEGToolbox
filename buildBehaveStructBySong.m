function buildBehaveStructBySong
%I need a better way to do this. This function works, but takes too long
%and when I think about it, it's just not the most efficient way of doing
%this. But for now I'm too lazy to rewrite a whole new function and
%structure. Sigh. - DTN 2016/03/01
%
%Edited: new loading of only the one variable 'Behav' has 1000x the speed
%of this function!!! No need to rewrite this function!! - DTN 2016/03/01
%(later on that day)

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

dirOne='/usr/ccrma/media/jordan/Experiments/Eng1.2/BehavOutV2d_softICAThresh';
dirTwo='/usr/ccrma/media/jordan/Experiments/Eng1.2/MatEpochedV2d_softICAThresh';

postfix = {'_a', '_b'};
for t=1:2
    
    cd(dirOne)
    eval(['load(''songAssignment' postfix{t} '.mat'');'])
    
    for i=1:size(songAssignment,1)
        bySong=[];
        
        for k=1:size(songAssignment,2)
            filename=sprintf('%s%s.mat', songAssignment{i,k},postfix{t});
            load([dirTwo filesep filename], 'Behav')
            trigger = i+20;
            
            for j=1:size(Behav.abs,2)
                if Behav.abs(1,j)==trigger
                    bySong(k,:) = Behav.abs(2:end,j)';
                end
            end
        end
        
        display(sprintf('\nsong%02d is done.',i));
        behaveStruct{i}=bySong;
        
    end
    
    behaveStruct=behaveStruct';
    eval(['save behaveStruct' postfix{t} '.mat behaveStruct'])
    display(sprintf('\nbehaveStruct%s is done.',postfix{t}));
    
    clearvars -except postfix dirOne dirTwo t
    
end
