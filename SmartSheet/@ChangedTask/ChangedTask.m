classdef ChangedTask
    properties
        name (1,1) string = missing
        Log
    end
    
    properties (SetAccess = private)
        oldNames
    end
    
    methods
        function self = ChangedTask(name)
            if nargin > 0
                self.name = name;
            end
            if nargin > 1
                self.Log = Log;
            end
        end
        
        function self = run(self)
            self.oldNames = getOldNames(
        end
    end
end