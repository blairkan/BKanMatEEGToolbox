function a = annotateFile(inputMethod)
% a = annotateFile(inputMethod)
% --------------------------------------------
% Blair - May 5, 2014
% Collects file annotations for the given session (experimenter name(s), 
% net, impedance threshold, session notes) via text input.
% If inputMethod == 1, you will get a pop-up window
% If inputMethod == 0, prompts will be given in the console
% If no arguments passed in, will assign inputMethod = 0.

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

if nargin==0 inputMethod=0; end

if inputMethod
    a.experimenter = inputdlg('Enter experimenter name(s): ', 's');
    a.net = inputdlg('Enter net size and serial number [S-H####]: ', 's');
    a.impThresh = inputdlg('Enter impedance threshold: ');
    a.notes = inputdlg('Enter any session notes: ', 's');
else
    a.experimenter = input('Enter experimenter name(s): ', 's');
    a.net = input('Enter net size and serial number [S-H####]: ', 's');
    a.impThresh = input('Enter impedance threshold: ');
    a.notes = input('Enter any session notes: ', 's');
end