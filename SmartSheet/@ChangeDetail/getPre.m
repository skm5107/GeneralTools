function self = getPre(self)
    [splits, endInd] = regexp(self.remainder, ChangeDetail.const.preExp, 'tokens', 'end');
    splits = splits{1};
    numStr = splits{ChangeDetail.const.numInd};
    self.num = str2double(numStr);
    self.name = nameClean(splits{ChangeDetail.const.nameInd});
    if isempty(self.num)
        self.num = NaN;
    end
    
    self.remainder = strtrim(extractAfter(self.remainder, endInd));
end

function name = nameClean(name)
    name = string(name);
    name = strip(name, '"');
end