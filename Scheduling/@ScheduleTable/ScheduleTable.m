classdef ScheduleTable
    properties
        Verbose = VerbosePrnt("None")
    end
    
    properties (GetAccess = private)
        raw table
    end
    
    properties (SetAccess = private)
        tbl
        checked
    end
    
    properties (Constant, Access = private)
        dur2day = ["s", 1/24/60/60
                   "m", 1/24/60
                   "h", 1/24
                   "d", 1
                   "w", 7];
    end
    
    methods
        function self = ScheduleTable(raw)
            if nargin > 0
                self.raw = raw;
            end
        end
        
        function [tbl, checked, self] = run(self)
            self.tbl = self.raw;
            self = self.clean;
            self = self.check;
            tbl = self.tbl;
            checked = self.checked;
        end
    end
    
    methods (Access = private)
        function self = clean(self)
            self = self.clean_complete();
            self = self.clean_duration();
            self = self.clean_cost();
        end
        
        function self = check(self)
            self = self.check_rownums();
        end
        
        self = clean_complete(self)
        self = clean_duration(self)
        self = clean_cost(self)
        self = check_rownums(self)
    end
end