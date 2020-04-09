classdef FormattedCSV < handle
    properties
        pathCSV (1,1) string = missing
        pathHead (1,1) string = missing
        skipLines (1,1) double = 0
    end
    
    properties (SetAccess = private)
        out
    end
    
    properties (Access = private)
        raw
    end
    
    methods
        function self = FormattedCSV(pathCSV, pathHead, skipLines)
            if nargin > 0
                self.pathCSV = pathCSV;
            end
            if nargin > 1 && Val.isFull(pathHead)
                self.pathHead = pathHead;
            end
            if nargin > 2
                self.skipLines = skipLines;
            end
        end
        
        function [out, self] = run(self)
            csv = readtable(self.pathCSV, 'TextType', 'string', 'DatetimeType', 'text', ...
                'PreserveVariableNames', true, 'HeaderLines', self.skipLines);
            self.raw = self.delExtra(csv);
            Heads = self.getHeaders();
            self.out = self.setMeta(Heads);
            self.out = NestTable(self.out).run;
            out = self.out;
        end
    end
    
    methods (Access = private)
        Heads = getHeaders(self)
        out = setMeta(self, rawHead)
        out = nestVars(self)
    end
    
    methods (Static, Access = private)
        raw = delExtra(raw)
    end
end