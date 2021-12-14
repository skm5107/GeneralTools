function self = loadRaw(self)
    self.opts.DataLines = [self.nrawSkipRows + 1, Inf];
    self.raw = readtable(self.pathRaw, self.opts);
    self = trimExtra(self);
end

function self = trimExtra(self)
    extraVars = regexp(self.raw.Properties.VariableNames, "^Var[\d]+", 'match');
    for jextra = Arr.uncell(extraVars)
        if cellfun(@isempty, self.raw.(jextra))
            self.raw.(jextra) = [];
            self.header.(jextra) = [];
            warning("FormattedCsv:Read:ExtraVar", "Deleting extra variable %s", jextra)
        end
    end
end