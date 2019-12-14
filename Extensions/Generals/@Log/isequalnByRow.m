function rows_tf = isequalnByRow(rowsA, rowsB)
    rows_tf = false([size(rowsA, 1), 1]);
    if size(rowsA, 1) ~= size(rowsB, 1)
        return
    end
    for irow = 1:size(rowsA, 1)
        rows_tf(irow) = isequaln(rowsA(irow,:), rowsB(irow,:));
    end
end