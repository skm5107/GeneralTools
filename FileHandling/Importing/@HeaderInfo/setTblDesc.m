function self = setTblDesc(self, irow)
    rawRow = self.getRawHead(irow);
    desc = join(rawRow, "");
    self.header.Properties.Description = desc;
end