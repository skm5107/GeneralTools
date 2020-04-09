function orig = defaultVars(orig)
    orig.Properties.VariableNames = defvars_make(1 : width(orig));
end

function varN = defvars_make(nums)
    varN = cellstr(repmat(Tbl.defVar, [1 length(nums)]) + string(nums));
end
