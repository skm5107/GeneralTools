classdef NestTable < Tbl
    properties (GetAccess = protected)
        flat table
        varNames cell
    end
    
    properties (SetAccess = protected)
        nested table
    end
    
    methods
        function self = NestTable(flat, varNames)
            if nargin > 0
                self.flat = flat;
            end
            if nargin > 1
                self.varNames = varNames;
            end            
        end
        
        function nested = run(self)     
            self.input_check;
            self.nested = table();
            for icol = 1:width(self.flat)
                ccol = Tbl.nested_name(self.varNames{icol}, self.flat{:, icol});
                self.nested = Tbl.nested_horzcat(self.nested, ccol);
            end
            nested = self.nested;
        end
    end
    
    methods (Access = private)
        function input_check(self)
            err = sprintf("Have %d columns and %d varNames.", length(self.varNames), width(self.flat));
            assert(width(self.flat) == length(self.varNames), "Tbl:Nest", err);
        end
    end
end
