function self = getHeaders(self)
    [self.Heads.header, self.Heads.iswData] = loadRaw(self.raw, self.pathHead, self.headSkipRows);
    self.Heads = self.Heads.run;
end

function [raw, headerAboveRaw] = loadRaw(raw, pathHead, headSkipRows)
    if ismissing(pathHead)
        headerAboveRaw = true;
    else
        headerAboveRaw = false;
        raw = readtable(pathHead, 'TextType', 'string', 'DatetimeType', 'text', ...
            'PreserveVariableNames', true, 'HeaderLines', headSkipRows);
    end
end