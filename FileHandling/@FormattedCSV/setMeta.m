function metad = setMeta(self, Heads)
    metad = self.raw;
    metad.Properties = Heads.Props;
    metad(Heads.delRows, :) = [];
    
    for icol = 1:width(metad)
        varName = metad.Properties.VariableNames{icol};
        varSpec = Heads.FormSpec(icol);
        metad.(varName) = Formatter(metad.(varName), varSpec).run;
    end
end