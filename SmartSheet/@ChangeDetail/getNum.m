function self = getNum(self)
    [strNum, endInd] = regexp(self.raw, ChangeDetail.const.numExp, 'match', 'end');
    self.num = double(strNum);
    
    if isempty(self.num)
        self.num = NaN;
    end
    
    self = self.getRemainder(endInd, ChangeDetail.const.numRem);
    self.remainder = strip(self.remainder, 'left', '"');
end