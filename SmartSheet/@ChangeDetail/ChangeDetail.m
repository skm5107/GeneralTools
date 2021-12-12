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
            self.remainder = self.raw;
            self = self.getNum();
            self = self.getName();
            self = self.splitDetails();
        end
    end
    
    methods (Access = private)
        self = getPre(self)
        self = getName(self, remainder)
        self = parseDetails(self, remainder)

        self = getRemainder(self, endInd, remVals)
    end
    
    methods (Static, Access = private)
        const = setup()            
    end
end