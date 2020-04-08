classdef Directory
    % Map of a directory to a specific sublevel
    
    properties
        path string
        subdir_maxlvl double = 10;
    end
    
    properties (Dependent)
        mapwtop
    end
    
    properties (SetAccess = private)
        map
    end
    
    properties (Hidden)
        topdir
        
        ignore_names = [Directory.alwaysIgnore_names, ".git", ".gitignore"];
        keep_names string
        ignore_namesPartial string
        keep_namesPartial string
    end
    
    properties (Constant, Access = private)
        alwaysIgnore_names = [".", ".."];
    end
    
    %% Constructor & Runner
    methods
        function self = Directory(path, subdir_maxlvl)
            if nargin > 0
                self.path = path;
            end
            if nargin > 1
                self.subdir_maxlvl = subdir_maxlvl;
            end
        end
        
        function [map, self] = run(self)
            self.topdir = self.dirlist_load(self.path);
            
            self.map = self.map_loop(self.topdir, 1);
            self.map = self.dirlist_clean(self.map);
            self.map = self.map_format(self.map);
            map = self.map;
        end
        
        function mapwtop = get.mapwtop(self)
            topFolders = Fldr.unfullfile(self.path);
            mapwtop = self.map;
            mapwtop.folders = cellfun(@(fldr) [topFolders, fldr], self.map.folders, 'uni', 0);
        end         
    end
    
    %% Methods
    methods (Access = private)
        function map = map_loop(self, input_list, iloop)
            map = input_list;
            for iname = 1:height(input_list)
                if input_list.isdir(iname) && iloop < self.subdir_maxlvl
                    current_path = fullfile(input_list.folder{iname}, input_list.name{iname});
                    current_list = self.dirlist_load(current_path);
                    level_list = map_loop(self, current_list, iloop + 1);
                else
                    level_list = table();
                end
                map = [map; level_list];
            end
        end
    end
    
    %% Cleaning
    methods (Access = private)
        function dirlist = dirlist_load(self, path)
            dirlist = struct2table(dir(path));
            delete_inds = self.names_match(dirlist, self.alwaysIgnore_names);
            dirlist(delete_inds,:) = [];
        end
        
        function cleaned = dirlist_clean(self, dirlist)
            cleaned = dirlist;
            if ~isempty(self.keep_names) || ~isempty(self.keep_namesPartial)
                keep_inds = self.names_match(dirlist, self.keep_names, self.keep_namesPartial);
                cleaned = dirlist(keep_inds,:);
            else
                delete_inds = self.names_match(dirlist, self.ignore_names, self.ignore_namesPartial);
                cleaned(delete_inds,:) = [];
            end
        end
        
        function inds = names_match(~, dirlist, fullNames, partialNames)
            if nargin > 2 && ~isempty(fullNames) && ~isempty(string(dirlist.name))
                inds = any(string(dirlist.name) == fullNames, 2);
            else
                inds = false([height(dirlist), 1]);
            end
            
            if nargin > 3 && ~isempty(partialNames)
                inds = or(inds, any(contains(dirlist.name, partialNames), 2));
            end
        end
        
        function tbl = map_format(self, tbl)
            if ~isempty(tbl)
                tbl.name = string(tbl.name);
                
                folder = erase(tbl.folder, cd);
                folder = erase(folder, self.path);
                tbl.folder = Fldr.unfullfile(folder);
                
                tbl.date = datetime(tbl.date);
                tbl.Properties.VariableNames{'folder'} = 'folders';
            end
        end
    end
    
    %% Dependents
    methods
        function self = set.path(self, path)
            self.path = path;
            [~, self] = run(self);
        end
        
        function self = set.subdir_maxlvl(self, subdir_maxlvl)
            self.subdir_maxlvl = subdir_maxlvl;
            [~, self] = run(self);
        end
    end
end