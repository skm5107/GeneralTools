classdef Fldr
    methods (Static)
        [pathVect, folderVect, fileName] = unfullfile(folders)
        dirfullpath(dirMapRow)
        fullpath = fullfile(varargin)

        function filenameExt = fileext(fullPath)
            [~, fileName, ext] = fileparts(fullPath);
            filenameExt = string(strcat(fileName, ext));
        end

        function cleaned = cleanPath(path)
            cleaned = strip(path, "/");
            cleaned = strip(cleaned, "\");
        end        
    end
        
    methods (Static)
        fileName = getCallingFile(priorNth)
        [startLoc, wantLoc] = moveUpLocation(wantFolder)
        
        function mkdirIfNone(dirName)
            orig = warning('off','MATLAB:MKDIR:DirectoryExists');
            mkdir(dirName)
            warning(orig);
        end
    end
end