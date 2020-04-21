function out = formatType(self, wasSplit)
    fcnHndl = Tbl.lookup(Frmt.key, self.FormSpec.typeSpec, "typeID", "convertHndl");
    fcnHndl = Arr.uncell(fcnHndl);
    if wasSplit
        out = cellfun(@(row) byRow(row, fcnHndl, self.FormSpec.styleSpec), self.mid, 'uni', false);
    else
        out = cellfun(@(row) byRow(row, fcnHndl, self.FormSpec.styleSpec), self.mid);
    end
end

function row = byRow(rowRaw, hndl, style)
    row = cellfun(@(raw) hndl(raw, style), Arr.cellify(rowRaw));
end