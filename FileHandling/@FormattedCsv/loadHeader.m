function self = loadHeader(self)
    self = checkIfHeaderFile(self);
    self = setHeadOpts(self);
    
    if self.nheadRows > 1
        self.opts.DataLines = [2, self.nheadRows];
        emptyTbl = false;
    else
        self.opts.DataLines = [1, 1];
        emptyTbl = true;
    end
    self.header = readtable(self.pathHeader, self.opts);
    if emptyTbl
        self.header(:,:) = [];
    end
end

function self = checkIfHeaderFile(self)
    if ismissing(self.pathHeader)
        self.nrawSkipRows = self.nrawSkipRows + self.nheadRows;
        self.pathHeader = self.pathRaw;
    else
        self.pathHeader = self.pathHeader;
    end
end

function self = setHeadOpts(self)
    detOpts = detectImportOptions(self.pathRaw);
    self.opts = Tbl.copyProps(detOpts, self.opts);
    
    optProps = properties(self.opts);
    for iopt = 1:length(self.headOpts)
        jopt = self.headOpts(iopt);
        if any(optProps == jopt)
            self.opts.(jopt) = iopt;
        end
    end
    
    self.opts.VariableNamingRule = 'preserve';
    self.opts = setvartype(self.opts, 'char');
end