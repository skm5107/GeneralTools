function metad = setMeta(self, Heads)
    metad = self.raw;
    metad = cleanExtra(metad, Heads);
    metad.Properties = Heads.Props;
    
    for icol = 1:width(metad)
        varName = metad.Properties.VariableNames{icol};
        varSpec = Heads.FormSpec(icol);
        metad.(varName) = Formatter(metad.(varName), varSpec).run;
    end
    
    keepcols = cellfun(@(iname) ~startsWith(iname, self.delCol_start), metad.Properties.VariableNames);
    metad(:,~keepcols) = [];
end

function metad = cleanExtra(metad, Heads)
    metad(Heads.delRows, :) = [];
    if length(Heads.Props.VariableNames) < width(metad)
       metad = delCols(metad, Heads.Props.VariableNames);
    end
end
function metad = delCols(metad, varNames)
    cols_qty = width(metad) - length(varNames);
    for icol = width(metad) : width(metad) - cols_qty +1
        delCols(icol) = ~Val.isFull([metad{:,icol}]);
    end
     metad(:, delCols) = [];    
end