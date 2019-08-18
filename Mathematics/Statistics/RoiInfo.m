classdef RoiInfo
    %Any specified ROI in channels

    properties
        bounds(1,2) double
    end
    
    properties (SetAccess = private)     
        fwhmLo_chan
        fwhmHi_chan
        
        lo
        hi
        mid
        
        inds
        width
        
        loInd
        hiInd
        midInd
    end
    
    %% Constructor
    methods
        function self = RoiInfo(bounds)
            if nargin > 0
                self.bounds = bounds;
            end
        end
    end
    
    methods
        function self = run(self)
            self.lo = min(self.bounds);
            self.hi = max(self.bounds);
            self.mid = mean([self.lo, self.hi]);
            
            self.inds = self.lo : self.hi;
            self.width = length(self.inds);
            
            self.loInd = 1;
            self.hiInd = self.width;
            self.midInd = round(self.width / 2); %%TODO:check use
            
        end
    end
end