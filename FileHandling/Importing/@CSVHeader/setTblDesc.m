function self = setTblDesc(self, headerRow)
    rawRow = self.getRawHead(headerRow);
    desc = join(rawRow, "");
    self.out.Properties.Description = desc;
end