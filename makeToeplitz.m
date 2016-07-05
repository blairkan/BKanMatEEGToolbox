function xT = makeToeplitz(x, nAdvance)
% xT = makeToeplitz(x, nAdvance)
% ------------------------------------
% Blair - April 18, 2016
% This function takes in a vector x and number of samples to advance it by
% and outputs a Toeplitz matrix. The first row of the Toeplitz matrix is a
% row vector of the input. Subsequent rows are preceded by increasing
% numbers of zeros and truncated accordingly. The total size of the matrix
% will thus be nAdvance + 1 x length(x).

if size(x,1) > size(x,2)
   disp('Transposing column input to row.')
   x = x(:)';
end

if (length(x)) <= nAdvance
   warning('Output will contain one or more zero rows due to input length.') 
end

r = [x zeros(1,nAdvance)];
c = [x(1) zeros(1, nAdvance)];
T = toeplitz(c, r);
xT = T(:,1:length(x));