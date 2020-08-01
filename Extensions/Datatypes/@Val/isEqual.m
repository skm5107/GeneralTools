function isEqual = isEqual(a,b)
    sameClass = class(a) & class(b);
    sameSize = size(a) == size(b);
    sameType = all(sameClass(:)) && all(sameSize(:));
    
    try
        bothMiss = ismissing(a) & ismissing(b);
    catch
        bothMiss = false;
    end
    
    bothEmpty = isempty(a) & isempty(b);
    sameVal = a == b;
    anyMatch = bothMiss + bothEmpty + sameVal;
    areMatches = anyMatch > 0;
    
    isEqual = sameType && all(areMatches(:));
end