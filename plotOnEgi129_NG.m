function varargout = plotOnEgi129_NG(data,msize)
%plotOnEgi - Plots data on a standarized EGI net mesh
%function meshHandle = plotOnEgi(data,msize)
%
%This function will plot data on the standardized EGI mesh with the
%arizona colormap.
%
%Data must be a 128 dimensional vector, but can have singleton dimensions,
%
% New version by Blair 20160309 - adding support for 129 channels.
% New Version by Nick 20170222 - adding support for multiple electrode
% sizes

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2017 Nick Gang
% Copyright 2017 Spero Nicholas (with input from Justin Ales and Benoit
% Cottereau)
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

data = squeeze(data);
datSz = size(data);

if datSz(1)<datSz(2)
    data = data';
end

%%%%%%%%%%%%%%% New for this version -- marker size %%%%%%%%%%%%%%%%%%%%
if nargin < 2
    warning('Marker size not specified. Setting ''msize'' to 10.'); 
    msize = 10;
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if size(data,1) == 128
    disp('Doing 128 chan')
    tEpos = load('defaultFlatNet.mat');
    tEpos = [ tEpos.xy, zeros(128,1) ];
    
    tEGIfaces = mrC_EGInetFaces( false );
    
    nChan = 128;
    
% NEW - FOR 129 CHANNELS    
elseif size(data,1) == 129
    disp('Doing 129 chan')
    tEpos = load('defaultFlatNet.mat');
    tEpos.xy = [tEpos.xy; [0 0]]; % Add reference electrode
    tEpos = [ tEpos.xy, zeros(129,1) ];
    
    tEGIfaces = mrC_EGInetFaces( true );
    
    nChan = 129;
    
    
elseif size(data,1) == 256
    
    tEpos = load('defaultFlatNet256.mat');
    tEpos = [ tEpos.xy, zeros(256,1) ];
    
    tEGIfaces = mrC_EGInetFaces256( false );
    nChan = 256;
else
    error('Only good for 3 montages: Must input a 128, 129, or 256 vector')
end


patchList = findobj(gca,'type','patch');
netList   = findobj(patchList,'UserData','plotOnEgi');


if isempty(netList),
    handle = patch( 'Vertices', [ tEpos(1:nChan,1:2), zeros(nChan,1) ], ...
        'Faces', tEGIfaces,'EdgeColor', [ 0.5 0.5 0.5 ], ...
        'FaceColor', 'interp');
    axis equal;
    axis off;
else
    handle = netList;
end

set(handle,'facevertexCdata',data,'linewidth',1,'markersize',msize,'marker','.');
set(handle,'userdata','plotOnEgi');

colormap(jmaColors('usadarkblue'));

if nargout >= 1
    varargout{1} = handle;
end
