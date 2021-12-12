function self = preClean(self)
    self.remainder = regexprep(self.raw, '""(.*)""', '"$1"');
end