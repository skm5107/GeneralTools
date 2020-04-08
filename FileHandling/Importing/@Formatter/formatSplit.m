function mid = formatSplit(self)
    if self.FormSpec.splitSpec == ""
        mid = self.raw;
    else
        splitter = self.escChar + self.FormSpec.splitSpec;
        mid = cellfun(@(raw) regexp(raw, splitter, "split"), self.raw, 'uni', false);
    end
end