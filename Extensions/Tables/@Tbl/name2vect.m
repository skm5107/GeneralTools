function varVect = name2vect(varNames, div)
    varVect = cell([length(varNames), 1]);
    for ivar = 1:length(varNames)
        varVect{ivar} = strsplit(varNames{ivar}, div);
    end
end
