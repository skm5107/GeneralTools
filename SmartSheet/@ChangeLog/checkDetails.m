function self = checkDetails(self)
    detailWords = string.empty;
    for irow = 1:height(self.log)
        details = self.log.Details(irow);
        [rowNum, rowChar] = getNum(details);
        name = getName(details);
        remainder = getRemainder(details, rowChar, name);
    end
    %get count for order of types
end

colonWords = string.empty;
for irow = 1:height(asgnd)
    details = asgnd.Details(irow);
    [rowNum, rowChar] = getNum(details);
    unquoted = eraseBetween(details, '"', '"', 'Boundaries', 'inclusive');
    
    revQuotes = reverse(unquoted);
    colons = extractBetween(revQuotes, " :", " ");
    colons = cellfun(@reverse, colons, 'UniformOutput', 0);
    
    isRow = cellfun(@(val) isequal(val, rowChar), colons);
    colons = colons(~isRow);
    cellfun(@(jcolon) flagMe(jcolon, details), colons)
    colonWords = [colonWords; colons];
end
colonWords = unique(colonWords);