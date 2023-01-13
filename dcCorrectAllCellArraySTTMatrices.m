function cellDC = dcCorrectAllCellArraySTTMatrices(cellIn, permuteInput)
% cellDC = dcCorrectAllCellArray3dMatrices(cellIn, permuteInput)
% ----------------------------------------------------------------------
% Blair - January 12, 2023
% 
% This function takes in a cell array of [space x time x trial] (STT)
% matrices, and DC corrects each trial "slice" in each matrix. The output
% is the same size as the input. 
%
% INPUTS
% - cellIn (required): A cell array containing a set of 3D EEG matrices. 
%   Each 3D matrix is assumed to be STT, but can also be 
%   [time x space x trial] (TST). If the latter, enter the flag to permute 
%   the input and output dimensions (see next input).
% - permuteInput (optional): Boolean of whether the data dimensions need to
%   be permuted from TST to STT and back again. If empty or not entered,
%   this input will default to false.
%
% OUTPUT
% - cellDC: A cell array containing a set of DC-corrected EEG matrices.
%   Each output matrix will be the same size as the corresponding input
%   (STT input --> STT output and TST input --> TST output). 

% If permuteInput empty or not empty, set to false.
if ~exist(permuteInput) || isempty(permuteInput)
    permuteInput = 0;
end

% How many cell array entries?
[nRow, nCol] = size(cellIn);

% Initialize the output
cellDC = cell(nRow, nCol);

% Doing in 'for' loop even if slower
for i = 1:nRow
   for j = 1:nCol
       
       thisIn = cellIn{i,j};
       
       % If input was TST, permute dimensions to STT
       if permuteInput, thisIn = permute(thisIn, [2 1 3]); end
       
       % DC correct each trial in the STT 3D matrix
       thisOut = dcCorrectAllTrialsInStruct(thisIn);
       
       % If input was TST, permute STT dimensions back to TST
       if permuteInput, thisOut = permute(thisOut, [2 1 3]); end
       
       % Add to output struct
       cellDC{i,j} = thisOut; 
       
       clear this*
       
   end
end