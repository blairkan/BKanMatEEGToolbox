function a = annotateFile(inputMethod)
% a = annotateFile(inputMethod)
% ---------------------
% Blair
% May 5, 2014
% Collects file annotations for the given session (experimenter name(s), 
% net, impedance threshold, session notes) via text input.
% If inputMethod == 1, you will get a pop-up window
% If inputMethod == 0, prompts will be given in the console
% If no arguments passed in, will assign inputMethod = 0.

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