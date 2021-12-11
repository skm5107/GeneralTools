function [mid, wasSplit] = formatSplit(self)
    %Split (comma-delimited) element based on another delimiter provided
    %(in the header)
    if self.FormSpec.splitSpec == ""
        mid = self.raw;
        wasSplit = false;
    else
        splitter = self.FormSpec.splitSpec;
        mid = cellfun(@(jraw) strsplit(jraw, splitter), self.raw, 'uni', false);
        wasSplit = true;
    end
end