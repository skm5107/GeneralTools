function self = loadHeader(self)
    if ismissing(self.pathHeader)
        self.rawSkipRows = self.rawSkipRows + self.headerRows;
        pathHead = self.pathRaw;
    else
        pathHead = self.pathHeader;
    end
    opts = detectImportOptions(pathHead);
    if self.headerRows > 1
        opts.DataLines = [2, self.headerRows];
        emptyTbl = false;
    else
        opts.DataLines = [1, 1];
        emptyTbl = true;
    end
    opts = setvartype(opts, opts.VariableNames, 'char');
    self.header = readtable(pathHead, opts);
    if emptyTbl
        self.header(:,:) = [];
    end
end