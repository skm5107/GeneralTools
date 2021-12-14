function self = loadRaw(self)
    opts = detectImportOptions(self.filePath);
    raw = readtable(self.filePath, opts);
    raw = cleanRaw(raw);
    self.raw = shorten(raw);
end

function raw = cleanRaw(raw)
    raw = removevars(raw, 'Source');
end

function raw = shorten(raw)
    cap = 100;
    if ~isnan(cap)
        raw = raw(1:cap, :);
        fprintf("Using only first %d rows of raw see ChangeLog.loadRaw\n", cap);
    end
end