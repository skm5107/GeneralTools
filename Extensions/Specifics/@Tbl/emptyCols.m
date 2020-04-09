function empty = emptyCols(hgt, varNames, varTypes)
    if nargin < 3
        varTypes = {'string'};
    else
        varTypes = cellstr(varTypes);
    end
    
    wid = length(varTypes);
    if nargin < 2
        varNames = Tbl.defvars_make(wid);
    else
        varNames = cellstr(varNames);
    end
    
    wid = max(length(varTypes), length(varNames));
    if length(varTypes) == wid && length(varNames) == 1
        varNames = repmat(varNames, [1, wid]);
    elseif length(varNames) == wid && length(varTypes) == 1
        varTypes = repmat(varTypes, [1, wid]);
    end
    
    empty = table('Size', [hgt, wid], 'VariableNames', varNames, 'VariableTypes', varTypes);
end