classdef FormattedCSV < handle
    properties
        pathCSV (1,1) string = missing
        pathHead (1,1) string = missing
    end
    
    properties (Hidden)
        rawSkipRows (1,1) double = 0
        headSkipRows (1,1) double = 0
        Heads HeaderInfo = HeaderInfo()
    end
    
    properties (SetAccess = private)
        out
    end
    
    properties (Access = private)
        raw
    end
    
    methods
        function self = FormattedCSV(pathCSV, pathHead, rawSkipRows)
            if nargin > 0
                self.pathCSV = pathCSV;
            end
            if nargin > 1 && Val.isFull(pathHead)
                self.pathHead = pathHead;
            end
            if nargin > 2
                self.rawSkipRows = rawSkipRows;
            end
        end
        
        function [out, self] = run(self)
            csv = readtable(self.pathCSV, 'TextType', 'string', 'DatetimeType', 'text', ...
                'PreserveVariableNames', true, 'HeaderLines', self.rawSkipRows);
            self.raw = self.delExtra(csv);
            
            self = self.getHeaders();
            self.out = self.setMeta(self.Heads);
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