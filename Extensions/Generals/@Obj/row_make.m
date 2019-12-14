function tbl = row_make(obj, props)
    tbl = table();
    for jprop = props
        if ~iscell(jprop{:})
            tbl.(jprop{:}) = obj.(jprop{:});
        else
            iprop = Arr.uncell(jprop);
            tbl.(iprop) = {obj.(iprop)};
        end
    end
end