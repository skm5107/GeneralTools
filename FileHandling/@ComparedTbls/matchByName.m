function self = matchByName(self)
    if self.matchByName
        self.new = reorderCols(self.orig, self.new);
        self.tolPos = reorderTols(self.orig, self.tolPos);
        self.tolNeg = reorderTols(self.orig, self.tolNeg);
    end
end

function other = reorderTols(orig, other)
    if istable(orig) && istable(other)
        other = movevars(other, orig.Properties.VariableNames, 'Before', 1);
    end
end