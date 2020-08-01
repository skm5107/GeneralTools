function setted = appendNoEmpty(current, new)
    if ~Val.isFull(current)
        setted = new;
    elseif ismissing(new)
        setted = missing;
    else
        setted = [current, new];
    end
end