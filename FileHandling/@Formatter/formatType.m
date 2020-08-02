function out = formatType(self, wasSplit)
    fcnHndl = Tbl.lookup(Frmt.key, self.FormSpec.typeSpec, "typeID", "convertHndl");
    fcnHndl = Arr.uncell(fcnHndl);
    if wasSplit
        out = cellfun(@(row) byRow(row, fcnHndl, self.FormSpec.styleSpec, wasSplit), self.mid, 'uni', false);
    else
        out = cellfun(@(row) byRow(row, fcnHndl, self.FormSpec.styleSpec, wasSplit), Arr.cellify(self.mid));
    end
end

function row = byRow(rowRaw, hndl, style, wasSplit)
    hndl = hndl.convertHndl{:,:};
    if wasSplit
        row = cellfun(@(raw) hndl(raw, style), Arr.cellify(rowRaw), 'uni', 0);
    else
        row = cellfun(@(raw) hndl(raw, style), Arr.cellify(rowRaw));
    end
end