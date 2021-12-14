classdef ChangeDetail
    properties
        raw (1,1) string
    end
    
    properties (SetAccess = private)
        num
        name
        
        old
        new
    end
    
    properties %(Access = private)
        remainder
        details
    end
    
    properties (Constant, Hidden)%, Access = private)
        missVal = '(\(blank\))'
        funcPre = "="
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
            self = self.getPre(ChangeDetail.const.pres);
            if self.remainder ~= ""
                self = self.splitDetails(ChangeDetail.const.splits);
                self = self.asgnDetails(ChangeDetail.const.parses, ChangeDetail.const.key);
                %self.checkAnswer()
            else
                self.old = ChangeDetail.const.parses.old;
                self.new = ChangeDetail.const.parses.new;
            end
        end
    end
    
    methods (Access = private)
        self = preClean(self)
        self = getPre(self, pres)
        self = splitDetails(self, splits)
        self = asgnDetails(self, parses, key)

        self = getRemainder(self, endInd, remVals)
    end
    
    methods (Static, Access = private)
        const = setup()            
    end
end