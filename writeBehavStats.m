function writeBehavStats
%  writeBehavStats
% ----------------------------
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

dirOne='/usr/ccrma/media/jordan/Experiments/Eng1.2/BehavOutV2d_softICAThresh';

postfix = {'_a', '_b'};
for k=1:2
    
    cd(dirOne);
    
    eval(['load(''behaveStruct' postfix{k} '.mat'');'])
    
    fileID = fopen(sprintf('Eng1.2%s_Behave_Responses_Stats.txt', postfix{k}),'w');
    
    fprintf(fileID, 'Behave Responses by Song\r\n\n');
    
    fprintf(fileID, 'Song #1: Ainvayi Ainvayi\r\n');
    for i=1:4:length(behaveStruct)
        song{i} = 'Ainvayi Ainvayi';
        if i==1
            fprintf(fileID, 'Version: Original Trimmed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'original';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        elseif i==5
            fprintf(fileID, 'Version: Reversed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'reversed';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        elseif i==9
            fprintf(fileID, 'Version: Phase Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'phase scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        elseif i==13
            fprintf(fileID, 'Version: Measures Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'measure scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        end
        
    end
    
    
    fprintf(fileID, '\nSong #2: Daaru Desi\r\n');
    for i=2:4:length(behaveStruct)
        song{i} = 'Daaru Desi';
        if i==2
            fprintf(fileID, 'Version: Original Trimmed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'original';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        elseif i==6
            fprintf(fileID, 'Version: Reversed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'reversed';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
            
        elseif i==10
            fprintf(fileID, 'Version: Phase Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'phase scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
            
        elseif i==14
            fprintf(fileID, 'Version: Measures Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'measure scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        end
        
    end
    
    
    fprintf(fileID, '\nSong #3: Haule Haule\r\n');
    for i=3:4:length(behaveStruct)
        song{i} = 'Haule Haule';
        if i==3
            fprintf(fileID, 'Version: Original Trimmed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'original';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        elseif i==7
            fprintf(fileID, 'Version: Reversed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'reversed';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
            
        elseif i==11
            fprintf(fileID, 'Version: Phase Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'phase scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
            
        elseif i==15
            fprintf(fileID, 'Version: Measures Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'measure scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        end
        
    end
    
    fprintf(fileID, '\nSong #4: Malang\r\n');
    for i=4:4:length(behaveStruct)
        song{i} = 'Malang';
        if i==4
            fprintf(fileID, 'Version: Original Trimmed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'original';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        elseif i==8
            fprintf(fileID, 'Version: Reversed; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'reversed';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
            
        elseif i==12
            fprintf(fileID, 'Version: Phase Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'phase scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
            
        elseif i==16
            fprintf(fileID, 'Version: Measures Scrambled; Trigger: %d\r\n', i+20);
            fprintf(fileID, '             Q1          Q2          Q3          Q4\r\n');
            fprintf(fileID, 'Mean:      %4.2f        %4.2f        %4.2f        %4.2f\n', mean(behaveStruct{i}(:,1)), mean(behaveStruct{i}(:,2)),mean(behaveStruct{i}(:,3)),mean(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Max:       %4.2f        %4.2f        %4.2f        %4.2f\n', max(behaveStruct{i}(:,1)), max(behaveStruct{i}(:,2)),max(behaveStruct{i}(:,3)),max(behaveStruct{i}(:,4)));
            fprintf(fileID, 'Min:       %4.2f        %4.2f        %4.2f        %4.2f\n\n', min(behaveStruct{i}(:,1)), min(behaveStruct{i}(:,2)),min(behaveStruct{i}(:,3)),min(behaveStruct{i}(:,4)));
            
            type{i} = 'measure scram';
            trigger{i} = i+20;
            songMean{i} = [mean(behaveStruct{i}(:,1)) mean(behaveStruct{i}(:,2)) mean(behaveStruct{i}(:,3)) mean(behaveStruct{i}(:,4))];
            songMax{i} = [max(behaveStruct{i}(:,1)) max(behaveStruct{i}(:,2)) max(behaveStruct{i}(:,3)) max(behaveStruct{i}(:,4))];
            songMin{i} = [min(behaveStruct{i}(:,1)) min(behaveStruct{i}(:,2)) min(behaveStruct{i}(:,3)) min(behaveStruct{i}(:,4))];
        end
        
    end
    fclose(fileID);
    
    simpleStatsResults = struct('song', song, 'trigger', trigger, 'type', type, 'mean', songMean, 'max', songMax, 'min', songMin);
    eval(['save simpleStatsResults' postfix{k} '.mat simpleStatsResults'])
    
    display(sprintf('\simpleStatsResults%s is done.',postfix{k}));
    
    clearvars -except dirOne postfix k
    
end