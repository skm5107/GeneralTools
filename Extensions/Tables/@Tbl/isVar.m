function [tf, val] = isVar(tbl, varName)
    tf = any(string(tbl.Properties.VariableNames) == string(varName)', 1);
    if any(tf)
        val = tbl{:,tf};
    else
        val = NaN;
    end
end