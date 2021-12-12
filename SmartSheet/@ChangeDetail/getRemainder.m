function self = getRemainder(self, endInd, remVals)
    if ~isempty(endInd)
        endInd = endInd + remVals(1);
    else
        endInd = remVals(2);
    end
    
    self.remainder = strtrim(extractAfter(self.remainder, endInd));
end