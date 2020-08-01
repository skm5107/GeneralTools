function emptied = empty_create(orig, valType)
    emptied = orig;
    for icol = 1:width(orig)
        typeRow = FormatKey.classRow_find(orig{:, icol});
        colName = emptied(:, icol).Properties.VariableNames;
        
        fillerVal = typeRow.(valType{:});
        fillerSz = size(emptied.(colName{:}));
        emptied.(colName{:}) = repmat(fillerVal{:}, fillerSz);
    end
end