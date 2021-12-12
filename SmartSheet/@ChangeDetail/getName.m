function self = getName(self)
    [self.name, endInd] = regexp(self.remainder, ChangeDetail.const.nameExp, 'match', 'end');
    self = self.getRemainder(endInd, ChangeDetail.const.nameRem);
    self.remainder = strtrim(strip(self.remainder, 'left', '"'));
end