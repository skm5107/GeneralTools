function varNames = vect2name(varVect, div)
    varNames = cell([1, length(varVect)]);
    for ivar = 1:length(varVect)
        varNames(ivar) = join(varVect{ivar}, div);
    end
end