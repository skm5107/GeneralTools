function self = compare(self)
    self.comp = Arr.cellcomp(self.new, self.orig, self.tolPos, self.tolNeg);
    self.compMeta = Arr.cellcomp(self.newMeta, self.origMeta);
    self = formatComp(self);
end

function self = formatComp(self)
    if istable(self.orig)
        self.comp = cell2table(self.comp);
        meta = Tbl.cell2meta(self.origMeta);
        self.comp.Properties = meta.Properties;
    end
end