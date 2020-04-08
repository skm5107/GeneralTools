function self = setTblProp(self, propName, headerRow)
    propRow = self.getRawHead(headerRow);
    self.out.Properties.(propName) = propRow;
end