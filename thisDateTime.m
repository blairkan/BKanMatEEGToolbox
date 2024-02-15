function dt = thisDateTime()
% dt = thisDateTime()
% ---------------------------
% Blair - Feb 15, 2024
%
% Quick function to return the current date and time as a character array.
%
% Inputs: None
%
% Output: 
% - dt: Character array of the current date and time. The format is as if 
%   the datestr function was called with 'yyyymmdd_HHMM'. The time is in
%   the local time zone. 
%
% See also: datestr

dt = char(datetime('now', 'TimeZone', 'local', 'Format', 'yyyyMMdd_HHmm'));