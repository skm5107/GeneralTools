classdef AutoSelector
    properties (Hidden)
        topPath (1,1) string
        requests
    end
    
    properties (SetAccess = private)
        matchPaths
    end
    
    properties (Access = private)
        map
        constFiles
    end
    
    properties (Hidden)
        Dir (1,1) Directory = Directory()
        Loader (1,1) FormattedCsv = FormattedCsv()
        descDiv (1,1) string = "_"
    end
    
    methods
        function self = AutoSelector(topPath, requests)
            if nargin > 0
                self.topPath = topPath;
            end
            if nargin > 1
                self.requests = requests;
            end
        end
        
        function self = select(self)
            self.map = self.Dir.run(); 
            self.constFiles = self.extractDescs();
            [~, matchInds] = Log.allany(self.constFiles, self.requests);
            self.matchPaths = self.map.fullPath(matchInds);
        end
        
        function out = load(self)
            raws = cellfun(@(ipath) self.loadEach(ipath), num2cell(self.matchPaths), 'uni', 0);
            out = vertcat(raws{:});
        end
    end
    
    methods
        function self = set.topPath(self, topPath)
            self.topPath = topPath;
            self.Dir.path = topPath; %#ok<MCSUP>
        end
    end
    
    methods (Access = private)
        function constFiles = extractDescs(self)
            constFiles = cellfun(@(ifile) regexp(ifile, self.descDiv, "split"), self.map.filename, 'uni', 0);
        end
        function raw = loadEach(self, ipath)
            self.Loader.pathCSV = ipath;
            raw = self.Loader.run();
        end
    end
end