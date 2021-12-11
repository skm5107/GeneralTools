function self = loadRaw(self)
    opts = detectImportOptions(fileName);
    raw = readtable(fileName, opts);
    raw = cleanRaw(raw);
    self.raw = raw;
end

function self = cleanRaw(raw)
    self.raw = removevars(raw, 'Source');
end