function out = formatType(self, wasSplit)
    fcnHndl = Tbl.lookup(Frmt.key, self.FormSpec.typeSpec, "typeID", "convertHndl");
    fcnHndl = clean(fcnHndl); 
    if wasSplit
        out = cellfun(@(row) fcnHndl(row, self.FormSpec.styleSpec), self.mid, 'uni', false);
    else
        out = cellfun(@(row) fcnHndl(row, self.FormSpec.styleSpec), Arr.cellify(self.mid));
    end
end

function fcnHndl = clean(fcnHndl)
    fcnHndl = Arr.uncell(fcnHndl);
    fcnHndl = fcnHndl.convertHndl{:,:};
end