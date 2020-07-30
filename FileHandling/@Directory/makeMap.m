function map = makeMap(self, path)
    raw = struct2table(dir(path));
    assert(~isempty(raw), "Directory:path", "path for Directory map is empty.\nTIP: Check current location.")
    map = customMap(self, raw);
    map = cleanMap(self, map);
end

function map = customMap(self, raw)
    map = cleanFiles(raw);
    map.date = cellfun(@(idate) datetime(idate, 'Format', self.inputDate), raw.date);
    map.isdir = raw.isdir;
    map.fullPath = string(cellfun(@(irow) Fldr.dirfullfile(map(irow, :)), num2cell(1:height(map)), 'uni', 0)');
end

function map = cleanMap(self, map)
    checker = erase(map.filename, self.ignoreIfOnly);
    inds = checker ~= "";
    map = map(inds, :);
end

function map = cleanFiles(raw)
    map = table();
    [~, map.filename, map.ext] = cellfun(@fileparts, raw.name, 'uni', 0);
    map.filename = string(map.filename);
    map.ext = string(map.ext);
    map.folder = Fldr.unfullfile(raw.folder);
end