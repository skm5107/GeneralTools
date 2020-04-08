classdef FormattedCSV < handle
    properties
        pathCSV string = missing
        pathHead string = missing
    end
    
    properties (SetAccess = private)
        out
    end
    
    properties (Access = private)
        raw
    end
    
    methods
        function self = FormattedCSV(pathCSV, pathHead)
            if nargin > 0
                self.pathCSV = pathCSV;
            end
            if nargin > 1
                self.pathHead = pathHead;
            end
        end
        
        function self = run(self)
            csv = readtable(self.pathCSV, 'TextType', 'string');
            self.raw = self.delExtra(csv);
            Heads = self.getHeaders();
            self.out = self.setMeta(Heads);
        end
    end
    
    methods (Access = private)
        Heads = getHeaders(self)
        out = setMeta(self, rawHead)
    end
    
    methods (Static, Access = private)
        raw = delExtra(raw)
    end
end