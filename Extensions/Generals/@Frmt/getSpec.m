function formSpec = getSpec(tbl)
    formSpec = cellfun(@(icol) getID(tbl{:, icol}), num2cell(1:width(tbl)));
    
end

function ispec = getID(ival)
    ispec = Tbl.lookup(Frmt.key, class(ival), "className", "typeID");
    ispec = ispec{1}(1);
end