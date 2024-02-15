function saveCurrentFigure(fnOut, saveSize, h, printMsg)
% saveCurrentFigure(fnOut, saveSize, h, printMsg)
% --------------------------------------------------------
% Blair - Feb 15, 2024
%
% This function saves out the current (or specified figure) with
% customizable specifications.
%
% Inputs (all optional):
% - fnOut: Output figure filename including extension (e.g., '.png' and 
%   full path. If empty or not entered, the function will save out the 
%   figure as 'saveCurrentFigure_yyyymmdd_HHMM.png' in the current
%   working directory.
% - saveSize: 
