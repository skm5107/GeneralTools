classdef AutoConst
    properties (GetAccess = private)
        topPath (1,1) string
        requests
    end
    
    properties (Access = private)
        map
        constFiles
    end
    
    properties (Hidden)
        Dir (1,1) Directory = Directory()
        constDiv (1,1) string = " "
    end
    
    methods
        function self = AutoConst(topPath, requests)
            if nargin > 0
                self.topPath = topPath;
            end
            if nargin > 1
                self.requests = requests;
            end
        end
        
        function [matches, self] = run(self)
            self.map = self.Dir.run(); 
            self.constFiles = self.extractConsts();
            [~, matchInds] = Log.allany(self.constFiles, self.requests);
            matches = self.map.fullPath(matchInds);
        end
    end
    
    methods
        function self = set.topPath(self, topPath)
            self.topPath = topPath;
            self.Dir.path = topPath; %#ok<MCSUP>
        end
    end
    
    methods (Access = private)
        function constFiles = extractConsts(self)
            constFiles = cellfun(@(ifile) regexp(ifile, self.constDiv, "split"), self.map.filename, 'uni', 0);
        end
    end
end