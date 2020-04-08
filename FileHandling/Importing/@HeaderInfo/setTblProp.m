function self = setTblProp(self, propName, irow)
    propRow = self.getRawHead(irow);
    self.header.Properties.(propName) = propRow;
end