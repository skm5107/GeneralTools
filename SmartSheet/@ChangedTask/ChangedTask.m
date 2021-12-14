classdef ChangedTask
    properties
        row (1,:) table
        log table
    end
    
    properties (SetAccess = private)
        prevRows
    end
    
    properties (Constant, Access = private)
        maxLev = 10
        firstName = "(blank)"
        maxTries = 10
    end
    
    methods
        function self = ChangedTask(row, log)
            if nargin > 0
                self.row = row;
            end
            if nargin > 1
                self.log = log;
            end
        end
        
        function self = run(self)
            self = getOldNames(self);
        end
    end
    
    methods (Access = private)
        self = getOldNames(self)
    end
end