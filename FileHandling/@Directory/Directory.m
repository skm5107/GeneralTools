classdef Directory
    properties (Hidden)
        path (1,1) string
        maxsubLvl (1,1) double = 10
    end
    
    properties (SetAccess = private)
        map
    end
    
    properties (Constant, Access = private)
        inputDate = "dd-MM-yyyy HH:mm:ss"
        ignoreIfOnly = "."
    end
    
    methods
        function self = Directory(path)
            if nargin > 0
                self.path = path;
            end
        end
        
        function [map, self] = run(self)
            self.map = self.map_loop(self.path, 1);
            map = self.map;
        end
    end
    
    methods (Access = private)
        map = map_loop(self, path, iloop)
        map = makeMap(self, path)
        newPaths = checkMap(self, map)
    end
end