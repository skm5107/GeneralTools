function logVect = num2log(numVect)
    vect = nan(size(numVect));
    for ind = 1:length(numVect)
        vect(ind) = Frmt.log(numVect(ind));
    end
    if ~any(isnan(vect))
        logVect = logical(vect);
    else
        logVect = vect;
    end
end