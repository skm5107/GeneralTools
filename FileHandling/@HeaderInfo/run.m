function self = run(self)
    for irow = 1:height(self.key)
        self = extractHeadRow(self, self.key(irow,:));
    end
    self.Props = self.header.Properties;
end

function self = extractHeadRow(self, keyRow)
    if keyRow.csvRow > 1
        headRow = self.header{keyRow.csvRow-1,:};
        self = setProp(self, keyRow.propName, headRow);
    end
end


function self = setProp(self, propName, raw)
    raw = cleanRaw(self, raw);
    if propName == "FormSpec"
        self.FormSpec = FormatSpec(raw);
        return
    elseif propName == "Description"
        raw = join(raw, "");        
    end
    self.header.Properties.(propName) = raw;
end

function raw = cleanRaw(self, raw)
    raw = string(raw);
    raw = strrep(raw, self.delChar, "");
end