function fullpath = findfile(partialName, topPath)
    map = Directory(topPath).run;
    ind = cellfun(@(irow) contains(irow, partialName), map.filename);
    fullpath = Fldr.dirfullpath(map(ind,:));
end