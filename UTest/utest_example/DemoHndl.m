classdef DemoHndl
    properties
        propA = []
        propB = string.empty
        propC = categorical.empty
    end
    
    methods
        function self = DemoHndl(propA, propB, propC)
            if nargin > 1
                self.propA = propA;
            end
            if nargin > 2
                self.propB = propB;
            end
            if nargin > 3
                self.propC = propC;
            end
        end
    end
end