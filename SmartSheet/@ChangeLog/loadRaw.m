function self = loadRaw(self)
    opts = detectImportOptions(self.filePath);
    raw = readtable(self.filePath, opts);
    raw = cleanRaw(raw);
    self.raw = raw(1:1000,:);
    fprintf("Using only first 1000 rows of raw see Changelog.loadRaw\n");
end

function raw = cleanRaw(raw)
    raw = removevars(raw, 'Source');
end