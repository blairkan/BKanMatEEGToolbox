function closeAllOpenScripts()
% closeAllOpenScripts()
% ------------------------------
% Blair - Feb 14, 2024
%
% This function closes all scripts that are currently open :)

closeNoPrompt(matlab.desktop.editor.getAll);