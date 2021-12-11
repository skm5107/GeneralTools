function out = formatType(self, wasSplit)
    %Format element to requested datatype
    fcnHndl = Tbl.lookup(Frmt.key, self.FormSpec.typeSpec, "typeID", "convertHndl");
    fcnHndl = clean(fcnHndl); 
    if wasSplit
        out = cellfun(@(row) fcnHndl(row, self.FormSpec.styleSpec), self.splitted, 'uni', false);
    else
        out = cellfun(@(row) fcnHndl(row, self.FormSpec.styleSpec), num2cell(self.splitted));
    end
end

function fcnHndl = clean(fcnHndl)
    fcnHndl = Arr.uncell(fcnHndl);
    fcnHndl = fcnHndl.convertHndl{:,:};
end