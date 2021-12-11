function lowPaths = checkMap(~, map)
    %Find paths for folders in a list of files and folders
    lowers = map(map.isdir, :);
    lowPaths = cellfun(@(irow) Fldr.dirfullpath(lowers(irow, :)), num2cell(1:height(lowers)), 'uni', 0);
end