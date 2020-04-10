classdef NestTable
    properties (GetAccess = private)
        raw
    end
    
    properties (Access = private)
        rawVars
        rawInds
        uniTops
    end
    
    properties (Constant, Access = private)
        nestDiv = "."
    end
    
    methods
        function self = NestTable(raw)
            if nargin > 0
                self.raw = raw;
            end
        end
        
        function [out, self] = run(self)
            out = self.raw;
            self = self.readRawVars(out);
            for icol = length(self.uniTops):-1:1
                [out, flatCol] = self.mergeEachCol(out, icol);
                self = self.readRawVars(out);
                out = NestTable.subnestLoop(out, flatCol);
            end
        end
    end
    
    methods (Access = private)
        self = readRawVars(self, out)
        [out, flatCol] = mergeEachCol(self, out, icol)
    end
    
    methods (Static, Access = private)
        out = subnestLoop(out, loc)
    end
end