function orig = delmissing(orig)
    notFull = ~cellfun(@Val.isFull, num2cell(orig));
    orig(notFull) = [];
end