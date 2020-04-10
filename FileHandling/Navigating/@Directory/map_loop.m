function [map, iloop] = map_loop(self, path, iloop)
    map = self.makeMap(path);
    newPaths = self.checkMap(map);
    if ~isempty(newPaths) && iloop <= self.maxsubLvl
        newMap = cellfun(@(ipath) self.map_loop(ipath, iloop+1), newPaths, 'uni', 0);
        map = vertcat(map, newMap{:});
    end
end