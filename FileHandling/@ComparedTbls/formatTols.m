function self = formatTols(self)
    self.tolPos = cleanTol(self.tolPos);
    if ismissing(self.tolNeg)
        self.tolNeg = cellfun(@Num.makeNeg, self.tolPos, 'uni', 0);
    else
        self.tolNeg = cleanTol(self.tolNeg);
    end
end

function tol = cleanTol(self, tol)
    if ismissing(tol)
        tol = 0;
    end
    if isscalar(tol)
        tol = Arr.pad(tol, self.stndSz, tol);
    end
end