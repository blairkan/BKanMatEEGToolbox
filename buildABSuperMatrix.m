function [A, B, indxAB, filesAB] = buildABSuperMatrix(songList)
% [A, B, indxAB, filesAB] = buildABSuperMatrix(songList)
% ------------------------------------------------
% Duc - Feb 23-24, 2016
% This function builds the super matrices A and B and provides the index for
% A & B (indxAB) from an inputted stimuli list: "songList". If "songList" is 
% not provided it will run through all the stimuli to generate A & B (a total 
% of 16 stimuli). 

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

%Optional:
% inDir = '/usr/ccrma/media/jordan/Experiments/Eng1.2/SongStructsV2d_softICAThresh_47subs';
% cd(inDir);

songtitle={};
datafile={};

if ~exist('songList') || isempty(songList)
    for i=1:16
        songtitle{i}=sprintf('song%d',i+20);
        datafile{i}=sprintf('data%d',i+20);
        songList=21:36;
    end
else
    for i=1:length(songList)
        songtitle{i}=sprintf('song%d',songList(i));
        datafile{i}=sprintf('data%d',songList(i));
    end
end

A=[];
B=[];
indxAB=[];
indxSub=1;
filesAB=[];

for k=1:length(songtitle)
    songA = sprintf('%s_a.mat', songtitle{k});
    songB = sprintf('%s_b.mat', songtitle{k});
    
    load(songA);
    load(songB);
    
    dataA = sprintf('%s_a', datafile{k});
    dataB = sprintf('%s_b', datafile{k});
    
    eval(['[rA cA subA]=size(' dataA ');'])
    eval(['[rB cB subB]=size(' dataB ');'])
    
    if rA==rB && cA==cB && subA==subB
        for t=1:subA
            
            eval(['A=[A ' dataA '(:,:,t)];'])
            eval(['B=[B ' dataB '(:,:,t)];'])
            
            filesAB(indxSub,1)=songList(k);
            filesAB(indxSub,2)=t;
            
            if k==1 && t==1
                indxAB(indxSub,1)= 1;
                indxAB(indxSub,2)= cA;
                indxSub=indxSub+1;
            else
                indxAB(indxSub,1)= indxAB(indxSub-1,2)+1;
                indxAB(indxSub,2)= indxAB(indxSub-1,2)+cA;
                indxSub=indxSub+1;
            end
        end
    end
    display(sprintf('\n%s is now completed.\n', songtitle{k}));
end