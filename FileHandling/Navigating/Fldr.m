classdef Fldr
    %Static methods for navigating folders
    
    %% Fullfile Methods
    methods (Static)
        function cleaned = cleanPath(path)
            cleaned = strip(path, "/");
            cleaned = strip(cleaned, "\");
        end
        
        function fullpath = dirfullpath(dirMapRow)
            Except(dirMapRow).verifyClass("table");
            folders = dirMapRow.folders{:};
            fullpath = fullfile(folders{:}, dirMapRow.name);
        end
    end
    
    methods (Static)
        function filenameExt = fileext(fullPath)
            [~, fileName, ext] = fileparts(fullPath);
            filenameExt = string(strcat(fileName, ext));
        end
        function fullpath = fullfile(varargin)
            for iprt = 1:length(varargin)
                if isempty(varargin{iprt})
                    varargin{iprt} = "";
                end
            end
            if isempty(varargin)
                varargin = {""};
            end
            fullpath = fullfile(varargin{:});
        end
        function [pathVect, folderVect, fileName] = unfullfile(folders)
            folders = string(folders);
            folders = strip(folders, 'both', '\');
            folders = strip(folders, 'both', '/');
            
            pathVect = cell(size(folders));
            folderVect = cell(size(folders));
            fileName = strings(size(folders));
            for ifldr = 1:size(folders, 1)
                [pathVect{ifldr}, folderVect{ifldr}, fileName(ifldr)] = Fldr.folder1_parse(folders(ifldr));
            end
        end
    end

    methods (Static, Access = private)
        function [pathVect, folderVect, fileName] = folder1_parse(folder)
            pathVect = strsplit(folder, ["/" "\"]);
            
            folderVect = pathVect(1:end-1);
            folderVect(isempty(folderVect)) = "";
            
            fileName = pathVect(:, end);
        end
    end        
       
    %% Current Location Methods
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