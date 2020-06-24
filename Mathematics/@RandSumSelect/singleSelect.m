function [iinds, iselects] = singleSelect(self)
    isum = NaN;
    itry = 0;
    while isnan(isum) && itry <= self.maxTry
        iinds = getInds(self);
        isum = getSum(self, iinds);
        itry = itry + 1;
    end
    assert(~isnan(isum), "try:max", "Could not find equivalent summation. Raise maxTry or check inputs")
    iselects = self.names(iinds);
end

function inds = getInds(self)
    inds = Rand.btwn([1 self.hgt], [1 self.wid], 0);
    inds = sub2ind([self.hgt self.wid], inds, 1:self.wid);
end

function isum = getSum(self, inds)
    isum = sum(self.wghtd(inds));
    if ~self.wantFcn(isum,self.wantSum)
        isum = NaN;
    end
end
