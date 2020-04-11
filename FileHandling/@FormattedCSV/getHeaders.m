function self = getHeaders(self)
    if ismissing(self.pathHead)
        isIncluded = true;
        rawHead = self.raw;
    else
        isIncluded = false;
        rawHead = readtable(self.pathHead, 'TextType', 'string', 'DatetimeType', 'text', ...
            'PreserveVariableNames', true, 'HeaderLines', self.headSkipRows);
    end
    self.Heads.header = rawHead;
    self.Heads.iswData = isIncluded;
    self.Heads = self.Heads.run;
end