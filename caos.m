function caos()
% caos()
% ------------------------------
% Blair - Feb 14, 2024
%
% Short for Close All Open Scripts: This function closes all scripts that 
% are currently open :)

closeNoPrompt(matlab.desktop.editor.getAll);