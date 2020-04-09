function self = readRawVars(self)
    self.rawVars = self.raw.Properties.VariableNames;
    parsedVars = cellfun(@parser, self.rawVars, 'uni', 0);
    [self.uniTops, self.rawInds] = getTops(parsedVars);
end

function parsed = parser(raw)
    parsed = split(raw, NestTable.nestDiv);
end

function [uniTops, rawInds] = getTops(parsedVars)
    topInds = num2cell(1:length(parsedVars));
    topVars = cellfun(@(itop) parsedVars{itop}(1), topInds);
    [uniTops, ~, rawInds] = unique(topVars);
end