classdef FullPath
    % Finds the full fileName and path using a partial fileName request and a map
    
    properties (GetAccess = protected)
        partialPath string
        dirMap table
    end
    
    properties (SetAccess = private)
        fileName string
        folders
        topPath string = ""
        fullPath string
    end
    
    properties (Access = private)
        partialParsed
    end
    
    %% Constructor
    methods
        function self = FullPath(partialPath, dirMap, topPath)
            if nargin > 0
                self.partialPath = partialPath;
            end
            if nargin > 1
                self.dirMap = dirMap;
            end
            if nargin > 2
                self.topPath = topPath;
            end
        end
        
        function [self, fileName, folders, topPath] = run(self)
             self.partialParsed = Fldr.unfullfile(self.partialPath){1};                 %#ok<SBTMP>
             if isempty(self.dirMap)
                 self = runNotPartial(self);
             else
                 self = runPartial(self);
             end
             
             for ifile = 1:length(self.fileName)
                self.fullPath(ifile, 1) = self.fullpath_make(ifile);
            end
            
            fileName = self.fileName;
            folders = self.folders;
            topPath = self.topPath;            
        end
    end
    
    %% Combiners
    methods (Access = private)
        function fullPath = fullpath_make(self, ifile)
            top = self.topPath;
            fldrs = self.getrow(self.folders, ifile);
            fldrpath = Arr.uncell(fldrs);
            file = self.getrow(self.fileName, ifile);
            fullPath = fullfile(top, fldrpath{:}, file);
        end
        
        function row = getrow(~, prop, ifile)
            if size(prop, 1) >= ifile
                row = prop(ifile, :);
            else
                row = "";
            end
        end
    end
    
    %% Parsers
    methods (Access = private)        
        function self = runNotPartial(self)
            self.folders = self.partialParsed(1:end-1);
            if isempty(self.folders)
                self.folders = "";
            end 
            self.fileName = self.partialParsed(end);
        end
        
        function self = runPartial(self)
            mapRow = mapRow_find(self);
            self.fileName = mapRow.name;
            self.folders = mapRow.folders;
        end        
    end
    
    methods (Access = private)
        function mapRow = mapRow_find(self)
            dirsOnly = self.dirMap(self.dirMap.isdir, :);
            nameMatch_inds = Str.closestMatch(dirsOnly.name, self.partialPath(end));
            mapRow = FullPath.folderMatch_confirm(self.partialPath(1:end-1), self.dirMap(nameMatch_inds,:));
        end
    end
    
    methods (Static, Access = private)
        function mapRow = folderMatch_confirm(reqFolders, matchMap)
            isFolderMatch = false([1, height(matchMap)]);
            for irow = 1:height(matchMap)
                containsAllReqFolders = any(matchMap.folders{irow} == reqFolders', 2);
                isFolderMatch(irow) = all(containsAllReqFolders(:));
            end
            
            Warn.warnIf(sum(isFolderMatch) ~= 1, "Dir:Unique", "Partial fileName does not correspond to unique row of directory map.")
            mapRow = matchMap(isFolderMatch,:);
        end
    end
end