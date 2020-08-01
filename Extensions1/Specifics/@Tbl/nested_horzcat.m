function joint = nested_horzcat(old, new)
    oldNames = old.Properties.VariableNames;
    newNames = new.Properties.VariableNames;
    
    [~, oldCols, newCols] = setxor(oldNames, newNames);
    joint = [old(:, oldCols), new(:, newCols)];
    
    sharedNames = cellstr(intersect(oldNames, newNames));
    for iname = 1:length(sharedNames)
        joint.(sharedNames{iname}) = values_check(old.(sharedNames{iname}), new.(sharedNames{iname}));
    end
end

function values = values_check(old, new)
    if istable(old) && istable(new)
        values = Tbl.nested_horzcat(old, new);
    elseif istable(old) || istable(new)
        values = [old, new];
    elseif old == new
        values = old;
    else
        assert("Nested table variables with same name have different values", "Tbl:Merge")
    end
end