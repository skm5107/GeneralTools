classdef Except
    % Various boolean checks that can throw custom errors
    
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
    
    properties (Constant, Access = private)
        component = "Custom";
    end
    
    methods
        function self = Except(testVal)
            if nargin > 0
                self.testVal = testVal;
            end
            
            try
                self.testVal_name = inputname(1);
            catch
                self.testVal_name = [];
            end
        end
    end
    
    methods (Static)
        function fullID = errID(checkName)
            self = Except;
            self.doThrow = false;
            method_hndl = str2func(checkName);
            id = method_hndl(self);
            fullID = self.fullID_make(id);
        end
    end
    
    methods (Access = private)
        function id = throw_check(self)
            if self.isErr && self.doThrow
                self.throwErr;
            else
                id = self.id;
            end
        end
    end
    
    %% Checks
    methods
        id = verifyIsMember(self, allowableSet)
        id = verifyClass(self, classOptions)
        id = verifyNumeric(self)
        id = verifyPositive(self)
        id = verifyEqual(self, reqVal, location)
        id = verifyBtwnIncld(self, reqVals, location)
    end
end