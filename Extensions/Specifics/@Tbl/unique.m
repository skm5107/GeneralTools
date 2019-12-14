function tbl = unique(tbl, keepFirst)
    %Delete indentical rows of a table
    %either keeping the first (default) or the last identical
    
    % Set Defaults & Split Table
    if nargin < 2
        keepFirst = true;
    end
    
    [cellCols, noncellCols] = tblCellCol_split(tbl);
    
    % Get Identical Rows
    delRows = [];
    for irow = 1:height(tbl)
        matches = ismatch_test(cellCols, noncellCols, irow);
        delRows = delRows_append(delRows, matches, keepFirst);
    end
    
    % Delete Identical Rows
    tbl(unique(delRows), :) = [];
end

% Split Table by Columns that Need Different Matching Algorithms
function [cellCols, noncellCols] = tblCellCol_split(tbl)
    isCellVar = false([1 width(tbl)]);
    for icol = 1:width(tbl)
        isCellVar(icol) = iscell(tbl{:,icol});
    end
    
    cellCols = tbl{:, isCellVar};
    noncellCols = tbl(:, ~isCellVar);
end

% Run Matching Algorithms on a Row
function matches = ismatch_test(cellCols, noncellCols, irow)
    matchCells = cellfun(@(c) isequaln(cellCols{irow,:}, c), cellCols);
    matchNonCells = all(noncellCols{irow,:} == table2array(noncellCols), 2);
    matches = find(all([matchCells, matchNonCells], 2));
end

% Append Identical Rows to Delete
function delRows = delRows_append(delRows, matches, keepFirst)
    if keepFirst
        delRows = [delRows; matches(2:end)];
    else
        delRows = [delRows; matches(1:end-1)];
    end
end