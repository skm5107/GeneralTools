function fullpath = dirfullpath(dirMapRow)
    Except(dirMapRow).verifyClass("table");
    folder = dirMapRow.folder{:};
    fullpath = fullfile(folder{:}, dirMapRow.filename + dirMapRow.ext);
end