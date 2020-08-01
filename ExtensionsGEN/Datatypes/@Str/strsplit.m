function splits = strsplit(strs, delimiter)
    strs = string(strs);
    splits = cell(size(strs));
    for istr = 1:length(strs)
        splits{istr} = strsplit(strs(istr), delimiter);
    end
end