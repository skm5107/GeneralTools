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
            [self.mid, wasSplit] = self.formatSplit();
            out = self.formatType(wasSplit);
        end
    end
    
    methods (Access = private)
        [out, wasSplit] = formatSplit(self)
        out = formatType(self, wasSplit)
    end
    
    methods (Static, Access = private)
        key = loadKey()
    end
end