classdef Fldr
    methods (Static)
        cleaned = cleanPath(path)
        
        fullpath = dirfullpath(dirMapRow)
        fullpath = fullfile(varargin)
        filenameExt = fileext(fullPath)
        [pathVect, folderVect, fileName] = unfullfile(folders)
    end
    
    methods (Static)
        fullpath = findfile(partialName, topPath)
        mkdirIfNone(dirName)        
        [startLoc, wantLoc] = moveUpLocation(wantFolder)
    end
end