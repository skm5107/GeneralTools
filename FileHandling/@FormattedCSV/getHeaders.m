function self = getHeaders(self)
    [self.Heads.header, self.Heads.iswData] = ...
        loadRaw(self.pathCsv, self.pathHead, self.headSkipRows);
    self.Heads = self.Heads.run;
    
    wid = size(self.Heads.Props.VariableNames, 2);
    self.readSpec = join(repmat("%q", [1 wid]), "");
end

function [raw, headerAboveRaw] = loadRaw(pathCsv, pathHead, headSkipRows)
    if ismissing(pathHead)
        headerAboveRaw = true;
        raw = readtable(pathCsv, 'TextType', 'string', 'DatetimeType', 'text', ...
            'PreserveVariableNames', true, 'HeaderLines', headSkipRows);
    else
        headerAboveRaw = false;
        raw = readtable(pathHead, 'TextType', 'string', 'DatetimeType', 'text', ...
            'PreserveVariableNames', true, 'HeaderLines', headSkipRows);
    end
end