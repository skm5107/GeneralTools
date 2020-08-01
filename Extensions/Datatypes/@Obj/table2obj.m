function obj = table2obj(tbl, obj, props)
    if nargin < 3
        props = intersect(tbl.Properties.VariableNames, string(properties(obj)));
    end
    
    for jprop = props(:)'
        try obj.(jprop{:}) = tbl.(jprop{:}); end %#ok<TRYNC>
    end
end