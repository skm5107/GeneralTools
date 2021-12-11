classdef Fldr
    methods (Static)
        cleaned = cleanPath(path)
        chr = getDelim()
        
        fullpath = dirfullpath(dirMapRow)
        fullpath = fullfile(varargin)
        
        function joined = joinfile(strs)
            celled = num2cell(strs);
            joined = fullfile(celled{:});
        end
        
        filenameExt = fileext(fullPath)
        function stripped = stripExt(fullPath)
            [path, name] = fileparts(fullPath);
            stripped = fullfile(path, name);
        end
        [pathVect, folderVect, fileName] = unfullfile(folders)
    end
    
    methods (Static)
        fullpath = findfile(partialName, topPath)
        mkdirIfNone(dirName)        
        [startLoc, wantLoc] = moveUpLocation(wantFolder)
    end
end