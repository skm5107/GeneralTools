classdef MatchedFile
    properties (GetAccess = protected)
        newPath string
        oldPath string
        Importer ImportKey
    end
    
    properties (SetAccess = private)
        newTable
        oldTable
    end
    
    properties (Access = private)
        Header
    end
    
    %% Constructor & Runner
    methods
        function self = MatchedFile(newPath, oldPath, Importer)
            if nargin > 0
                self.newPath = newPath;
            end
            if nargin > 1
                self.oldPath = oldPath;
            end
            if nargin > 2
                self.Importer = Importer;
            end
        end
        
        function [newTable, oldTable, self] = run(self)
            if ~isempty(self.Importer)
                self.Header = self.getHeaderInfo(self.newPath);
                self.newTable = AutoImportKeyed(self.Header, FullPath(self.newPath).run).run;
                self.oldTable = AutoImportKeyed(self.Header, FullPath(self.oldPath).run).run;
            else
                self.newTable = AutoImported(self.newPath).run;
                self.oldTable = AutoImported(self.newPath).run;
            end
            
            self.newTable.Properties.Description = char(self.newPath);
            self.oldTable.Properties.Description = char(self.oldPath);
            
            newTable = self.newTable;
            oldTable = self.oldTable;
        end
    end
    
    %% Internal Methods
    methods (Access = private)
        function Header = getHeaderInfo(self, path)
            partialFile = Fldr.fileext(path);
            [alias, subName] = ImportKey.alias_lookup(self.Importer.files, partialFile);
            Header = KeyedHeader(self.Importer, alias, subName).run;
        end
    end
end