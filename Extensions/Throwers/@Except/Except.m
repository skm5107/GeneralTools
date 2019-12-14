classdef Except
    properties (GetAccess = protected)
        testVal
        testVal_name string
    end
    
    properties (Access = private)
        id string
        msg string
        isErr logical
        reqFcn function_handle
        
        doThrow logical = true
    end
    
    properties (Access = private)
        prefix = "Custom";
    end
    
    methods
        function self = Except(testVal, prefix)
            if nargin > 0
                self.testVal = testVal;
            end
            if nargin > 1
                self.prefix = prefix;
            end
            
            try
                self.testVal_name = inputname(1);
            catch
                self.testVal_name = [];
            end
        end
    end
    
    methods (Static)
        fullID = errID(checkName)
    end
    
    methods (Access = private)
        id = throw_check(self)
        throwErr(self)
        
        function fullID = fullID_make(self, id)
             fullID = sprintf("%s:%s", self.prefix, id);
        end        
    end   
    
    methods
        id = verifyIsMember(self, allowableSet)
        id = verifyDims(self, reqSz)
        id = verifyClass(self, classOptions)

        id = verifyNumeric(self)
        id = verifyPositive(self)
        id = verifyEqual(self, reqVal, location)
        id = verifyBtwnIncld(self, reqVals, location)      

        id = verifyFileOpens(self)
    end    
end