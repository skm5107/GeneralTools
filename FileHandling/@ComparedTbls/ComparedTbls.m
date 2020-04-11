classdef ComparedTbls
    properties (Hidden)
        orig
        new
        tolPos = missing
        tolNeg = missing
        
        printPath (1,1) string = missing
        matchByname = false
        fillerChar (1,1) string = HeaderInfo().delChar
    end
    
    properties (SetAccess = private)
        comp
        compMeta
    end
    
    properties (Access = private)
        origMeta
        newMeta
        stndSz
    end
    
    methods
        function self = ComparedTbls(orig, new, tolPos, tolNeg)
            if nargin > 0
                self.orig = orig;
            end
            if nargin > 1
                self.new = new;
            end
            if nargin > 2
                self.tolPos = tolPos;
            end
            if nargin > 3
                self.tolNeg = tolNeg;
            end
        end
        
        function self = run(self)
            self = self.matchByName();
            self = self.formatContent();
            self = self.formatTols();
            self = self.compare();
        end
        
        function comp = print(printPath, tfHeaders)
            if nargin > 0
                self.printPath = printPath;
            end
            if nargin > 1
                tfHeaders = false;
            end
            self.writeComp(tfHeaders);
            comp = self.comp;
        end
    end
    
    methods (Access = private)
        self = matchByName(self)
        self = formatContent(self)
        self = formatTols(self)
        self = compare(self)
        writeComp(self, tfHeaders)
    end
end