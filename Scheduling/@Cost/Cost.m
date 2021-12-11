classdef Cost
    properties
        base (1,1) double = NaN
        type (1,1) categorical = missing
    end
    
    properties (Dependent, Hidden)
        row
    end
    
    methods
        function self = Cost(base, type)
            if nargin > 0
                self.base = base;
            end
            if nargin > 1
                self.type = type;
            end
        end
    end
    
    methods
        function row = get.row(self)
            row = table();
            row.base = self.base;
            row.type = self.type;
        end
    end
end