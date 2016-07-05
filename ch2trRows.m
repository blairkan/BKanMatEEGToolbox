function y = ch2trRows(x, nCh, nTr, N)
% y = ch2trRows(x, nCh, nTr, N)	
% ------------------------------------
% This function takes the matrix x, whose rows correspond to electrodes,
% and returns the matrix y, whose rows are trials.
% x = input data matrix, size is nCh x (nTr*N)
% y = output data matrix, size is nTr x (nCh*N)
% nCh = number of electrodes (usually 124)
% nTr = number of trials, usually length(Triggers)
% N = number of samples per trial
%
% See also tr2chRows chRows2cube trRows2cube cube2chRows cube2trRows

y = NaN(nTr, nCh*N);

% Turn each row of x into nTrxN matrix to add to y.
for i = 1:nCh
	currCh = x(i,:);
	temp = reshape(currCh,N,[])';
	yCols = (i-1)*N+(1:N);
	y(:,yCols) = temp;
end
	
end