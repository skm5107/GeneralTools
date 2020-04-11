function self = setTblProp(self, propName, irow)
    if ~isnan(irow)
        propRow = self.getRawHead(irow);
        self.header.Properties.(propName) = propRow;
    end
end