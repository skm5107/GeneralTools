classdef ConstMapper
    % Directory map of CSV files from only relevant folders (<ids>/Constants)
    
    properties
        ids string
        map
    end
    
    properties (Constant, Access = private)
        topFolder = "Constants";
        constExt = ".csv";
        idDivider = "_";
    end
    
    %% Constructor
    methods
        function self = ConstMapper(ids)
            if nargin > 0
                self.ids = ids;
            end
        end
    end
    
    %% Getter
    methods
        function [map, self] = run(self)
            paths = fullfile(self.ids, self.topFolder);
            map = table();
            for ipth = 1:length(paths(:))
                newmap = self.map_make(paths(ipth));
                if ~isempty(newmap)
                    map = [map; self.map_make(paths(ipth))]; %#ok<AGROW>
                end
            end
        end
    end
    
    %% Methods
    methods (Access = private)
        function map = map_make(self, path)
            map = Directory(path).run;
            if ~isempty(map)
                fileRows = contains(map.name, self.constExt);
                map = map(fileRows, :);
                map.folders = cellfun(@(fldr) [path, fldr], map.folders, 'uni', 0);
                map.ids = self.fileIds_parse(map.name);
            else
                map.ids(:) = {};
            end
        end
        
        function ids = fileIds_parse(self, fileNames)
            names = cellfun(@(file) erase(file, self.constExt), fileNames, 'uni', 0);
            ids = cellfun(@(name) strsplit(name, self.idDivider), names, 'uni', 0);
        end
    end
end