function self = loadRaw(self)
    self.opts.DataLines = [self.nrawSkipRows + 1, Inf];
    self.raw = readtable(self.pathRaw, self.opts);
end