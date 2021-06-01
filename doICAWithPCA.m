function W = doICAWithPCA(x, nPC)

% W = doICAWithPCA(x, nPC)
% -------------------------
% Blair - June 1, 2021
% This function runs the EEGLAB ica function and returns the unmixing
% matrix W that will transform the data matrix from channel space to source
% space. This is an alternate version of the doICA function, with the PCA
% flag turned on.
%
% INPUTS (required)
% - x: Electrodes-by-feature (typically time) data matrix
% - nPC: Integer number of PCs to retain. Setting to zero turns off the PCA
%   flag.
%
% OUTPUT
% - W: Electrode-by-electrode unmixing matrix.
%
% Reference: https://sccn.ucsd.edu/~arno/eeglab/auto/runica.html
%
% See also doICA doCellICA batchICA batchCellICA

% This software is licensed under the 3-Clause BSD License (New BSD License), 
% as follows:
% -------------------------------------------------------------------------
% Copyright 2021 Blair Kaneshiro
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% 1. Redistributions of source code must retain the above copyright notice, 
% this list of conditions and the following disclaimer.
% 
% 2. Redistributions in binary form must reproduce the above copyright notice, 
% this list of conditions and the following disclaimer in the documentation 
% and/or other materials provided with the distribution.
% 
% 3. Neither the name of the copyright holder nor the names of its 
% contributors may be used to endorse or promote products derived from this 
% software without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ?AS IS?
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.

assert(nargin == 2, ...
    ['This function requires two inputs: The electrode-by-time data matrix ' ...
    'and the number of PCs to retain.']);

[weights, sphere] = runica(x, 'extended', 1, 'pca', nPC);
W = weights * sphere;