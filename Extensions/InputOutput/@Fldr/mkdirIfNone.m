function mkdirIfNone(dirName)
    orig = warning('off','MATLAB:MKDIR:DirectoryExists');
    mkdir(dirName)
    warning(orig);
end