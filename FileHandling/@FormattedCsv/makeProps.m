function self = makeProps(self)
    for irow = 1:height(self.header)
        if self.headProps(irow) == "FormSpec"
            self.FormSpec = FormatSpec(self.header{irow, :});
        elseif self.headProps(irow) == "Description"
            self.Heads.Description = string(join(self.header{irow, :}, ""));
        else
            self.Heads.(self.headProps(irow)) = self.header{irow, :};
        end
        self.Heads.VariableNames = self.header.Properties.VariableNames;
    end
end