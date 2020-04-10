function out = formatType(self, wasSplit)
    fcnHndl = Frmt.findFcn(self.FormSpec.typeSpec);
    if wasSplit
        out = cellfun(@(row) byRow(row, fcnHndl, self.FormSpec.styleSpec), self.mid, 'uni', false);
    else
        out = cellfun(@(row) byRow(row, fcnHndl, self.FormSpec.styleSpec), self.mid);
    end
end

function row = byRow(rowRaw, hndl, style)
    row = cellfun(@(raw) hndl(raw, style), Arr.cellify(rowRaw));
end