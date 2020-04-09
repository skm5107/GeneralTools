function trans = transpose(raw)
    newHeight = max(cellfun(@(elem) size(elem, 2), table2cell(raw)));
    trans = repmat(raw, [newHeight 1]);
    for jprop = raw.Properties.VariableNames
        newVal = raw.(jprop{:})';
        trans.(jprop{:}) = [newVal; repmat(newVal, [newHeight - size(newVal,1), 1])];
    end
end