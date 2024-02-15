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
%   the (now deprecated) datestr function were called with output format 
%   'yyyymmdd_HHMM'. Output is given in the user's local time zone.
%
% See also: datestr, datetime

dt = char(datetime('now', 'TimeZone', 'local', 'Format', 'yyyyMMdd_HHmm'));