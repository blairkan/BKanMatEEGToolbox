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
% - cellIn (required): A 3D matrix of EEG data. Is assumed to be STT, but
%   can also be [time x space x trial] (TST). If the latter, enter the 
%   flag to permute the input and output dimensions (see next input).
% - permuteInput (optional): Boolean of whether the data dimensions need to
%   be permuted from TST to STT and back again. If empty or not entered,
%   this input will default to false.