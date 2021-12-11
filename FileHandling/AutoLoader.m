classdef AutoLoader
    properties (Hidden)
        topPath (1,1) string
        requests
    end
    
    properties (SetAccess = private)
        selectPaths
        selectTags
    end
    
    properties %(Access = private)
        map
        allTags
    end
    
    properties (Hidden)
        Dir (1,1) Directory = Directory()
        Loader (1,1) FormattedCsv = FormattedCsv()
        descDiv (1,1) string = "_"
    end
    
    methods
        function self = AutoLoader(topPath, requests)
            if nargin > 0
                self.topPath = topPath;
            end
            if nargin > 1
                self.requests = requests;
            end
        end
        
        function self = select(self)
            self.map = self.Dir.run();
            self.allTags = self.extractTags();
            [~, selectInds] = Log.allany(self.allTags, self.requests);
            self.selectTags = self.allTags(selectInds);
            self.selectPaths = self.map.fullPath(selectInds);
        end
        
        function [out, tags] = load(self)
            inds = 1 : length(self.selectPaths);
            out = cellfun(@(ipath) self.loadEach(ipath), ...
                          num2cell(inds), 'uni', 0);
            tags = self.selectTags;
        end
    end
    
    methods
        function self = set.topPath(self, topPath)
            self.topPath = topPath;
            self.Dir.path = topPath; %#ok<MCSUP>
        end
    end
    
    methods (Access = private)
        function allTags = extractTags(self)
            fullPaths = cellfun(@self.makePath, self.map.folder, ...
                                self.map.filename, 'uni', 0);
            allTags = cellfun(@(ifile) ...
                              regexp(ifile, self.descDiv, "split"), ...
                              fullPaths, 'uni', 0);
        end
        function raw = loadEach(self, ipath)
            self.Loader.pathCsv = self.selectPaths(ipath);
            raw = self.Loader.run();
        end
        
        function full = makePath(self, folders, filename)
            folderPath = Fldr.joinfile(folders);
            cleaned = Str.eraseUpto(folderPath, self.topPath);
            [top, lvl] = fileparts(cleaned);
            fldrs = strip(join([top, lvl], self.descDiv), self.descDiv);
            file = join(string(filename), self.descDiv);
            full = fldrs + self.descDiv + file;
        end
    end
end