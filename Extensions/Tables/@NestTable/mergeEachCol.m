function [out, flatCol] = mergeEachCol(self, out, icol)
    iname = self.uniTops{icol};
    iraws = find(icol == self.rawInds);
    if hasNestDiv(out(:, iraws))
        out = mergevars(out, iraws, 'NewVariableName', iname, 'MergeAsTable', true);
        [out, flatCol] = cleanSubNames(out, iname, iraws(1));
    else
        flatCol = NaN;
    end
end

function [cleaned, loc] = cleanSubNames(cleaned, iname, loc)
    subTable = cleaned{:, loc};
    [subTable, fullyNested] = renameVars(subTable, iname);
    cleaned = Tbl.substituteCol(cleaned, subTable, loc);
    if fullyNested
        loc = NaN;
    end
end

function [subTable, fullyNested] = renameVars(subTable, iname)
    newNames = Str.eraseStart(subTable.Properties.VariableNames, iname + NestTable.nestDiv);
    fullyNested = ~any(contains(newNames, NestTable.nestDiv));
    subTable.Properties.VariableNames = newNames;
    subTable = table(subTable);
    subTable.Properties.VariableNames = {iname};        
end

function hasNest = hasNestDiv(cols)
    varNames = cols.Properties.VariableNames;
    hasNest = any(contains(varNames, NestTable.nestDiv));
end