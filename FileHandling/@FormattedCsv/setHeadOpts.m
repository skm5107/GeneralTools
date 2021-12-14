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
end