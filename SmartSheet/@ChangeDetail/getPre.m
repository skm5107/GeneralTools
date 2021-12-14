function self = getPre(self, pres)
    [splits, endInd] = getSplits(self, pres);
    self.num = getNum(splits, pres);
    self.name = getName(splits, pres);
    self.remainder = getRemainder(self.remainder, endInd);
end

function [splits, endInd] = getSplits(self, pres)
    [splits, endInd] = regexp(self.remainder, pres.exp, 'tokens', 'end');
    if ~isempty(endInd)
        splits = splits{1};
    else
       pres.expMiss = sprintf('(^Row?)( *?)([\\d]*?)(: ?)%s( *)', ChangeDetail.missVal);
       [splits, endInd] = regexp(self.remainder, pres.expMiss, 'tokens', 'end');
       splits = splits{1};
    end
end

function num = getNum(splits, pres)
    numStr = splits{pres.numInd};
    if ~isempty(numStr)
        num = str2double(numStr);
    else
        num = NaN;
    end
end

function name = getName(splits, pres)
    name = splits{pres.nameInd};
    name = string(name);
    name = strip(name, '"');
end

function remainder = getRemainder(remainder, endInd)
    remainder = extractAfter(remainder, endInd);
    remainder = strtrim(remainder);
end