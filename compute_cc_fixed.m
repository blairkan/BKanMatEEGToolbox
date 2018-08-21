function cc = compute_cc_fixed(X,Y,wins)

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2015 Jacek P. Dmochowski
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

if nargin<3, error('Not enough arguments'); end

if ( (size(X,1)~=size(Y,1)) || (size(X,2)~=size(Y,2)) )
    error('Input matrices X and Y must have the same size')
end

D=size(X,2);
Nwindows=size(wins,1);
cc=zeros(Nwindows,D);

% for i = 1:Nwindows
%     windx=wins{i};            
%     num = mean( X(windx,:).*Y(windx,:) ) - mean(X(windx,:)).*mean(Y(windx,:));
%     den = sqrt(mean(X(windx,:).^2) - (mean(X(windx,:))).^2) .* sqrt(mean(Y(windx,:).^2) - (mean(Y(windx,:))).^2);
%     cc(i,:)=num./den;
% end

% for i = 1:Nwindows
%     windx=wins{i};            
%     num = nanmean( X(windx,:).*Y(windx,:) ) - nanmean(X(windx,:)).*nanmean(Y(windx,:));
%     den = sqrt(nanmean(X(windx,:).^2) - (nanmean(X(windx,:))).^2) .* sqrt(nanmean(Y(windx,:).^2) - (nanmean(Y(windx,:))).^2);
%     cc(i,:)=num./den;
% end


for i = 1:Nwindows
    windx=wins{i};   
%     disp(['Computing correlations over ' num2str(length(windx)) ' time points'])
    for c=1:size(X,2)        
        [Rxy,Rxx,Ryy] = nanRXY(X(windx,c).',Y(windx,c).');
        cc(i,c)=Rxy/sqrt(Rxx*Ryy);
        cc(i,c)=real(cc(i,c)); %?
    end    
end
