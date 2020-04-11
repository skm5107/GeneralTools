function raw = delExtra(raw)
    checkMat = raw{:,:} ~= "";
    checkVect = sum(checkMat, 2);
    lastRow = find(checkVect, 1, 'last');
    raw = raw(1:lastRow, :);
end