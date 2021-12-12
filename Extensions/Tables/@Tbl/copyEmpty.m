function tbl = copyEmpty(src)
    tbl = src;
    for jvar = string(tbl.Properties.VariableNames)
        cls = class(tbl.(jvar));
        missVal = Obj.cast(missing, cls);
        tbl.(jvar) = repmat(missVal,height(tbl), 1);
    end
end