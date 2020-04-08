function out = formatType(self)
    switch self.FormSpec.typeSpec
        case 'q'
            hndl = @Frmt.str;
        case 'C'
            hndl = @Frmt.cat;
        case 'L'
            hndl = @Frmt.log;
        case 't'
            hndl = @Frmt.table;
        case 'r'
            hndl = @Frmt.cell;
        case {'d', 'I', 'u', 'n', 'o', 'x', 'f', 'e', 'E', 'g', 'G'}
            hndl = @Frmt.num;
        case {'D', 'T'}
            hndl = @Frmt.clock;
        otherwise
            error("invalid typeSpec character")
    end
    out = cellfun(@(row) byRow(row, hndl, self.FormSpec.styleSpec), self.mid, 'uni', 0);
end

function row = byRow(rowRaw, hndl, style)
    row = cellfun(@(raw) hndl(raw, style), Arr.cellify(rowRaw));
end