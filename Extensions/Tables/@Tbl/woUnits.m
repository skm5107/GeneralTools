function [val, inds_tf] = woUnits(tbl, varName)
    vars = tbl.Properties.VariableNames;
    splitUnits = Str.strsplit(vars, Tbl.unitsDivider);
    noUnits = cellfun(@(var) getNoUnits(var), splitUnits);
    inds_tf = noUnits == string(varName);
    val = tbl{:, inds_tf};
end

function noUnits = getNoUnits(split)
    if length(split) < 2
        noUnits = split;
    else
        noUnits = join(split(1:end-1), "_");
    end
end