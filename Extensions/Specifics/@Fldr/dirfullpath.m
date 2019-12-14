function fullpath = dirfullpath(dirMapRow)
    Except(dirMapRow).verifyClass("table");
    folders = dirMapRow.folders{:};
    fullpath = fullfile(folders{:}, dirMapRow.name);
end