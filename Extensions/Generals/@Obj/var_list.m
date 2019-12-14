function varNames = var_list(anyObj)
    if any(ismember(["table" "class"], Obj.allclasses(anyObj)))
        varNames = anyObj.Properties.VariableNames;
    else
        varNames = fields(anyObj);
    end
end