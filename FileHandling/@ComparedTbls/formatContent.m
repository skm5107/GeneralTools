function self = formatContent(self)
    [self.orig, self.origMeta] = convertTbl(self.orig);
    [self.new, self.newMeta] = convertTbl(self.new);
    self = standardizeSize();
end

function [formed, meta] = convertTbl(raw)
    if istable(raw)
        meta = Tbl.meta2cell(raw);
        formed = table2cell(raw);
    else
        formed = num2cell(raw);
        meta = {[]};
    end
end

function self = standardizeSize(self)
    assert(ndims(self.orig) == ndims(self.new), "ComparedTbls:size", "orig & new arrays must have same number of dimensions")
    if all(size(self.orig) == size(self.new))
        self.stndSz = size(self.orig);
    else
        warning("ComparedTbls:size", "Righthand padding orig & new arrays to same size.")
        self.stndSz = max(size(self.orig), size(self.new));
        self.orig = Arr.pad(self.orig, self.stndSz, {[]});
        self.new = Arr.pad(self.new, self.stndSz, {[]});
    end
end