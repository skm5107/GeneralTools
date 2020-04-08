classdef Formatter
    properties (GetAccess = private)
        raw
        FormSpec
    end
    
    properties (Access = private)
        mid
        escChar = "\"
    end
    
    methods
        function self = Formatter(raw, FormSpec)
            if nargin > 0
                self.raw = raw;
            end
            if nargin > 1
                self.FormSpec = FormSpec;
            end
        end
        
        function out = run(self)
            self.mid = self.formatSplit();
            out = self.formatType();
        end
    end
    
    methods (Access = private)
        out = formatSplit(self)
        out = formatType(self)
    end    
end