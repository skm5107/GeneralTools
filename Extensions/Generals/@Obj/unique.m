function [uniqued, total_qty] = unique(rows)
    uniqued = [];
    for irow = 1:size(rows, 1)
        isFirst = rowIsFirst(rows, irow);
        if isFirst
            uniqued = [uniqued; rows(irow,:)];
        end
    end
    
    for iuni = 1:size(uniqued, 1)
        [~, total_qty(iuni)] = matchRow(uniqued(iuni), uniqued);
    end
end

function isFirst = rowIsFirst(rows, irow)
    before = rows(1:irow-1, :);
    thisRow = rows(irow, :);
    isFirst = ~matchRow(thisRow, before);
end

function [hasMatch, total_qty] = matchRow(thisRow, allRows)
    hasMatch = false;
    total_qty = 1;
    for irow = 1:size(allRows, 1)
        isEqual = Cls.hndlEqual(thisRow, allRows(irow,:));
        total_qty = isEqual + total_qty;
        hasMatch = isEqual || hasMatch;
    end
end
