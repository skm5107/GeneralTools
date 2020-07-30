function [nest, nestNames] = nested_name(varName, val)
    %Create a nested table from a nested variable name, e.g. varName = "a.b.c"
    nestNames = cellstr(strsplit(varName, Tbl.nestDivider));
    
    if nargin < 2
        nest = missing;
        return
    end
    
    nest = table();
    nest.(nestNames{end}) = val;
    for ilvl = length(nestNames)-1 : -1 : 1
        nest.(nestNames{ilvl}) = nest;
        nest(:, 1:end-1) = [];
    end
end