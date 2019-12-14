function nested = metaInfo_add(self, rawTable)
    assert(isequaln(width(rawTable), self.nVars), ...
        "Table Header Formatter: width of table for metaInfo_add(self, table) must equal self.nVars.")
    
    metad = self.variables_mult(rawTable);
    metad.Properties.VariableUnits = cellstr(self.varUnits);
    metad.Properties.VariableDescriptions = cellstr(self.varDescs);
    metad.Properties.Description = char(self.tblDesc);
    metad.Properties.VariableNames = cellstr(self.varNames);
    nested = metad;
%     nested = table_nest(metad);
end

function nested = table_nest(metad)
    nested = table();
    for icol = 1:width(metad)
        
    end
end

function Var = nestCol(Var, colName)
    parsed = fliplr(split(colName, ".")');
    for inest = 1:length(parsed)
        Var = table(Var);
        Var.Properties.VariableNames = parsed(inest);
    end
end