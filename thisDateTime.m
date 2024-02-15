function dt = thisDateTime(longform)
% dt = thisDateTime(longform)
% ---------------------------
% Blair - Feb 15, 2024
%
% Quick function to return the current date and time as a character array.
%
% Inputs:
% - longform (optional): Whether to also include the hours and minutes in
%   the returned time date stamp. If empty or not entered, will default to
%   true.
%
% Output:
% - dt: Character array of the current date and time. The format is as if
%   the (now deprecated) datestr function were called with output format
%   'yyyymmdd_HHMM' if longform is true, and 'yyyymmdd' if longform is
%   false. Output is given in the user's local time zone.
%
% See also: datestr, datetime

if nargin < 1 || isempty(longform), longform = 1; end

if longform
    dt = char(datetime('now', 'TimeZone', 'local', 'Format', 'yyyyMMdd_HHmm'));
else
    dt = char(datetime('now', 'TimeZone', 'local', 'Format', 'yyyyMMdd'));
end