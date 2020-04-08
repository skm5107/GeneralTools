function Heads = getHeaders(self)
    if ismissing(self.pathHead)
        isIncluded = true;
        rawHead = self.raw;
    else
        isIncluded = false;
        rawHead = readtable(self.pathHead, 'TextType', 'string');
    end
    
    Heads = HeaderInfo(rawHead, isIncluded).run;
end