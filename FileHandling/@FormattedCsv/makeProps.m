function self = makeProps(self)
    for irow = 1:height(self.header)
        if self.headRows(irow) == "FormSpec"
            self.FormSpec = FormatSpec(self.header{irow, :});
        elseif self.headRows(irow) == "Description"
            self.Heads.Description = string(join(self.header{irow, :}, ""));
        else
            self.Heads.(self.headRows(irow)) = self.header{irow, :};
        end
        self.Heads.VariableNames = self.header.Properties.VariableNames;
    end
end