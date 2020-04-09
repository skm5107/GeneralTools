function self = setTblDesc(self, irow)
    if ~isnan(irow)
        rawRow = self.getRawHead(irow);
        desc = join(rawRow, "");
        self.header.Properties.Description = desc;
    end
end