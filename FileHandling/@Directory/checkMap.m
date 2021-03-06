function lowPaths = checkMap(~, map)
    lowers = map(map.isdir, :);
    lowPaths = cellfun(@(irow) Fldr.dirfullfile(lowers(irow, :)), num2cell(1:height(lowers)), 'uni', 0);
end