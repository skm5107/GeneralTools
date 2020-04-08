function Heads = getHeaders(self)
    if ismissing(self.pathHead)
        isInSitu = true;
        rawHead = self.raw;
    else
        isInSitu = false;
        rawHead = readtable(self.pathHead, 'TextType', 'string');
    end
    
    Heads = CSVHeader(rawHead, isInSitu).run;
end