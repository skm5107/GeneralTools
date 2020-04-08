function out = setMeta(self, Heads)
    out = self.raw;
    out.Properties = Heads.Props;
    out(Heads.delRows, :) = [];
    
    for icol = 1:width(out)
        varName = out.Properties.VariableNames{icol};
        out.(varName) = Formatter(out.(varName), Heads.FormSpec(icol)).run;
    end
end