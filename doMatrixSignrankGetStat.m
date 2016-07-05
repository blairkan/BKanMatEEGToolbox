function [p, h, s] = doMatrixSignrankGetStat(dataIn, tail)
% [p, h, s] = doMatrixSignRank(dataIn, tail)
% --------------------------------------------
% Blair - April 4, 2016
% This function takes in a time x subs matrix of data and performs the
% Wilcoxon signed rank test on every row of data (that is, across all
% subjects for a given time point). A vector of p values is returned.
%
% The 'tail' argument is optional. If no tail is supplied, the test will do
% two tailed. If a tail is supplied, you will get a message printed to the
% console.
%
% Outputs: 
% p is the vector of p-values
% h is the returns on the tests
% s is an array struct with the test statistics

if nargin < 2
    disp(['No tail provided. Using two-tailed test.'])
    theTail = 'both';
else
    switch tail
        case {'right', 'r', 'pos'}
            disp('Right tail specified.')
            theTail = 'right';
        case {'left', 'l', 'neg'}
            disp('Left tail specified.')
            theTail = 'left';
        case {'both', 'center', 'two', 'b', 'm'}
            disp('Both tails specified.')
            theTail = 'both';
        otherwise 
            error('Unexpected tail! Exiting.')
    end
end

nObs = size(dataIn,1);
nSubs = size(dataIn,2);

disp(['Performing Wilcoxon signed rank tests:'])
disp([num2str(nObs) ' observations (rows)'])
disp([num2str(nSubs) ' data points per observation (columns)'])

p = nan(nObs,1);
h = nan(nObs,1);

for i = 1:nObs
    [p(i), h(i), s(i)] = signrank(dataIn(i,:), 0, 'tail', theTail);
end