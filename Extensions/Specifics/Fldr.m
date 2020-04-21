classdef Fldr
    properties (Constant, Hidden)
        pathDivs = {"/" "\"}
        extDiv = "."
    end
        
    methods (Static)
        function cleaned = cleanPath(path)
            cleaned = strip(path, "/");
            cleaned = strip(cleaned, "\");
        end
        
        function folders = unfullfile(path)
            path = Fldr.cleanPath(path);
            folders = regexp(path, "[\\/]", "split");
        end
            
        function path = dirfullfile(mapRow)
            fldr = mapRow.folder{:};
            path = fullfile(fldr{:}, mapRow.filename + mapRow.ext);
        end

        function namewExt = fileext(fullPath)
            [~, fileName, ext] = fileparts(fullPath);
            namewExt = string(strcat(fileName, ext));
        end
        
        function [ext, pathname] = checkext(filepath)
            [path, name, ext] = fileparts(filepath);
            ext = Str.eraseStart(ext, Fldr.extDiv);
            pathname = fullfile(path, name);
        end
        
        function filepath = changeext(filepath, ext)
            [~, pathname] = Fldr.checkext(filepath);
            filepath = pathname + Fldr.extDiv + ext;
        end
    end
    
    methods (Static)
        function mkdirIfNone(dirName)
            orig = warning('off','MATLAB:MKDIR:DirectoryExists');
            mkdir(dirName)
            warning(orig);
        end
        
        function [startLoc, wantLoc] = moveUpLocation(wantFolder)
            Except(wantFolder).verifyClass("string");
            
            startLoc = pwd;
            locVect = Fldr.unfullfile(startLoc);
            locVect = locVect{:};
            wantLevel = find(locVect == wantFolder);
            wantLoc = fullfile(locVect{1:wantLevel});
            cd(wantLoc)
        end
    end
end