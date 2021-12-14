function self = loadRaw(self)
    self = self.setHeadOpts();
    self.opts.VariableNamingRule = 'preserve';
    self.opts.DataLines = [self.rawSkipRows + 1, Inf];
    self.opts
    self.opts = setvartype(self.opts, 'char');
    self.raw = readtable(self.pathRaw, self.opts);
    self.raw
end