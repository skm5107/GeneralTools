function  [self, metad] = formatMeta(self)
    metad = table();
    if ~isempty(self.FormSpec)
        for icol = 1:width(self.raw)
            varName = self.raw.Properties.VariableNames{icol};
            if varName == "Row"
                varName = "RowReNamed";
            end
            newCol = Formatter(self.raw{:,icol}, self.FormSpec{icol}).run;
            metad.(varName) = newCol;
        end
    else
        metad = self.raw;
    end
    if ~isempty(self.Heads)
        metad.Properties = self.Heads;
    end
    self.metad = metad;
end