classdef VerbosePrnt
    properties
        mode
    end
    
    properties (Constant)
        modes = categorical(["None", "Failures", "All"])
    end
    
    methods
        function self = VerbosePrnt(mode)
            if nargin > 0
                self.mode = mode;
            end
        end
    end
    
    methods
        function prnt(self, isPass, passPrnt, failPrnt)
            if isPass
                str = passPrnt;
            else
                str = failPrnt;
            end
            
            if self.mode == "All" || self.mode == "Failures" && ~isPass
                fprintf(str)
            end
        end
    end
end