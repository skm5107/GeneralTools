function filenameExt = fileext(fullPath)
    [~, fileName, ext] = fileparts(fullPath);
    filenameExt = string(strcat(fileName, ext));
end