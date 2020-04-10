function [mid, wasSplit] = formatSplit(self)
    if self.FormSpec.splitSpec == ""
        mid = self.raw;
        wasSplit = false;
    else
        splitter = self.escChar + self.FormSpec.splitSpec;
        mid = cellfun(@(raw) regexp(raw, splitter, "split"), self.raw, 'uni', false);
        wasSplit = true;
    end
end