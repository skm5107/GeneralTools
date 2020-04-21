function key = loadKey()
    raw = {"VariableNames", 1, {@setProp};
        "FormSpec", 2, {@setProp};
        "VariableUnits", 3, {@setProp};
        "VariableDescriptions", 4, {@setProp};
        "Description", 5, {@setProp}};
    key = cell2table(raw, 'VariableNames', ["propName", "csvRow", "setHndl"]);
end
