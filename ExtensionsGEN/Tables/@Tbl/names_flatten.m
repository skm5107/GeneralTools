function varVect = names_flatten(nested)
    varNames = nested.Properties.VariableNames;
    for jvar = varNames
        varVect = cell.empty;
        varVect = [varVect, jvar]; %#ok<*AGROW>
        if istable(nested.(jvar{:}))
            varVect = varName_loop(nested.(jvar{:}), varVect);
        else
            varVect = varVect(1:end-1);
        end
    end
end

function varVect = varName_loop(subtable, varVect)
    varNames = subtable.Properties.VariableNames;
    for jvar = varNames
        varVect = [varVect, jvar]; %#ok<*AGROW>
        if istable(subtable.(jvar{:}))
            varVect = varName_loop(subtable.(jvar{:}), varVect);
        else
            string(varVect)
            varVect = varVect(1:end-1);
        end
    end    
end