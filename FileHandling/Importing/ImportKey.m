classdef ImportKey
    properties (SetAccess = immutable)
        projWord string
    end
    
    properties (SetAccess = private)
        files table
        headers table
        topPath string
    end
    
    properties (Constant, Access = private)
        folderLoc = "Constants";
        filesName = "csvs.csv"
        headsName = "headers.csv"
    end
    
    methods
        function self = ImportKey(projWord)
            if nargin > 0
                self.projWord = projWord;
            end
        end
  
        function self = run(self)
            self.topPath = fullfile(self.projWord, self.folderLoc);
            raw = self.key_read(self.filesName);
            self.files = self.files_format(raw);
            
            self.headers = self.key_read(self.headsName);
        end
    end
    
    methods (Static)
        function [alias, subName] = alias_lookup(fileKey, partialName)
            map = ImportKey.dirMap_fake(fileKey);
            [~, fullName] = FullPath(partialName, map).run;
            
            assert(~isempty(fullName), "Import:File", sprintf("No Alias for FileName: %s", partialName))
            assert(length(unique(fullName)) == 1, "Import:File", sprintf("FileName does not have unique alias+subname: %s", partialName))
            
            irow = fileKey.fileName == unique(fullName);
            alias = Arr.uncell(fileKey.alias(irow));
            subName = Arr.uncell(fileKey.subName(irow));
        end
    end
    
    methods (Static, Access = private)
        function map = dirMap_fake(fileKey)
            map = table();
            map.name = fileKey.fileName;
            map.folders = fileKey.folders;
            map.isdir = true(size(map.folders));
        end
    end
    
    methods (Access = private)
        function raw = key_read(self, fileName)
            pathKey = fullfile(self.topPath, fileName);
            raw = AutoImported(pathKey).run;
        end    
    end
    
    methods (Static, Access = private)
        function files = files_format(files)
            [~, files.folders, files.fileName] = Fldr.unfullfile(files.filePath);
            files.filePath = [];
            files = movevars(files, {'fileName', 'folders'}, 'Before', 1);
        end
    end
end