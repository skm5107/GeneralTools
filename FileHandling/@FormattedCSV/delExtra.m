function raw = delExtra(raw)
%     checkMat = ~cellfun(@Val.isFull, table2cell(raw));
%     checkVect = sum(checkMat, 2);
%     lastRow = find(checkVect, 1, 'last');
%     if isempty(lastRow)
%         lastRow = height(raw);
%     end
%     raw = raw(1:lastRow, :);
end