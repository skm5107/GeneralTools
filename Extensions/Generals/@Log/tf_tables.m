function catTbl = tf_tables(logTbl)
    catTbl = logTbl;
    for jvar = catTbl.Properties.VariableNames
        if islogical(logTbl.(jvar{:}))
            catTbl.(jvar{:}) = categorical(logTbl.(jvar{:}));
        end
    end
end
