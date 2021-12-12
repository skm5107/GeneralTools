function tbl = asgnMatchVars(src, tbl)
    matchVars = intersect(tbl.Properties.VariableNames, src.Properties.VariableNames);
    for jvar = string(matchVars)
        tbl.(jvar) = src.(jvar);
    end
end