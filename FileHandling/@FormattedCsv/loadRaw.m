function self = loadRaw(self)
    opts = detectImportOptions(self.pathRaw);
    opts.VariableNamingRule = 'preserve';
    opts.DataLines = [self.rawSkipRows + 1, Inf];
    opts = setvartype(opts, opts.VariableNames, 'char');
    self.raw = readtable(self.pathRaw, opts);
end