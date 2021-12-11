classdef Formatter
    properties (Hidden)
        raw
        FormSpec
    end
    
    properties (Access = private)
        splitted
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
            %Parse and datatype raw values
            [self.splitted, wasSplit] = self.formatSplit();
            out = self.formatType(wasSplit);
        end
    end
    
    methods (Access = private)
        [out, wasSplit] = formatSplit(self)
        out = formatType(self, wasSplit)
    end
end