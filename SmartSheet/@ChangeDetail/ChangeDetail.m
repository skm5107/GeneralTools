classdef ChangeDetail
    properties
        raw (1,1) string
    end
    
    properties (SetAccess = private)
        num
        name
        
        old = table()
        new = table()
    end
    
    properties %(Access = private)
        remainder
        details
    end
    
    properties (Constant, Hidden)%, Access = private)
        const = ChangeDetail.setup()
    end
    
    methods
        function self = ChangeDetail(raw)
            if nargin > 0
                self.raw = raw;
            end
        end
        
        function self = run(self)
            self = self.preClean();
            self = self.getPre();
            if self.remainder ~= ""
                self = self.splitDetails();
                self = self.parseDetails();
            end
        end
    end
    
    methods (Access = private)
        self = preClean(self)
        self = getPre(self)
        self = splitDetails(self)
        self = parseDetails(self)

        self = getRemainder(self, endInd, remVals)
    end
    
    methods (Static, Access = private)
        const = setup()            
    end
end