classdef NestTable
    properties (GetAccess = private)
        raw
    end
    
    properties (SetAccess = private)
        out
    end
    
    properties %(Access = private)
        rawVars
        parsedVars
        rawTops
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
        
        function out = run(self)
            self.rawVars = self.raw.Properties.VariableNames;
            self.parsedVars = cellfun(@(jvar) split(jvar, NestTable.nestDiv), self.rawVars, 'uni', 0);
            
            self.rawTops = self.getTops();
            [uTops, ~, rawInds] = unique(self.rawTops);
            
            self.out = self.raw;
            for icol = length(uTops):-1:1
                jraws = icol == rawInds;
                self = self.mergeVars(uTops(icol), jraws);
            end
            out = self.out;
        end
    end
    
    methods (Access = private)
        topvars = getTops(vars)
    end
end