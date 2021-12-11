classdef Time
    properties (GetAccess = private)
        raw
        Verbose = VerbosePrnt("None")
    end
    
    properties (SetAccess = private)
        dur_bus (1,1) duration
        start (1,1) datetime
        finish (1,1) datetime
        
        checked
    end
    
    properties (Dependent)
        row
    end
    
    methods
        function self = Time(raw)
            if nargin > 0
                self.raw = raw;
            end
        end
        
        function self = run(self)
            self = self.assignVals();
            self = self.checkVals();
        end
    end
    
    methods
        function row = get.row(self)
            row = table();
            row.dur_bus = self.dur_bus;
            row.start = self.start;
            row.finish = self.finish;            
        end
    
        function mnth = endMonth(self)
            mnth = month(self.finish);
        end
    end
    
    methods (Access = private)
        self = assignVals(self)
        self = checkVals(self)
    end
end