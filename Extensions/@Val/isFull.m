function isFilled = isFull(val)
    isFilled = true;
    val = Arr.uncell(val);
    notFullHndls = {@isempty, @ismissing, @isDblQuote};
    
    for ifcn = 1:length(notFullHndls)
        try %#ok<TRYNC>
            icheckNotFull = notFullHndls{ifcn};
            isFilled = isFilled && ~icheckNotFull(val);
        end
    end
    
    if isempty(isFilled)
        isFilled = false;
    end
end

function tf = isDblQuote(val)
    tf = val == "";
end