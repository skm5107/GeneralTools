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
    
    %% Constructor
    methods
        function self = Except(testVal)
            if nargin > 0
                self.testVal = testVal;
            end
            
            try %Only works in constructor
                self.testVal_name = inputname(1);
            catch
                self.testVal_name = [];
            end
        end
    end
    
    %% Error Getter & Thrower
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
        function id = verifyIsMember(self, allowableSet)
            self.id = "IsMember";
            if ~self.doThrow, id = self.id; return, end
            
            self.msg = sprintf("variable %s must match 1 of [%s]", self.testVal, join(allowableSet, ", "));
            self.isErr = ~all(ismember(self.testVal, allowableSet));
            id = self.throw_check();
        end
        
        function id = verifyDims(self, reqSz)
            self.id = "IsSize";
            if ~self.doThrow, id = self.id; return, end
            
            self.msg = sprintf("variable of size [%s] must be of size [%s]", ...
                Prnt.vectprintf(size(self.testVal)), Prnt.vectprintf(reqSz));
            
            testSz = size(self.testVal);
            if ~all(size(testSz) == size(reqSz))
                self.isErr = true;
            else
                dimsToCheck = isfinite(reqSz);
                self.isErr = ~all(testSz(dimsToCheck) == reqSz(dimsToCheck));
            end
            id = self.throw_check();
        end
        
        function id = verifyClass(self, classOptions)
            self.id = "CorrectClass";
            if ~self.doThrow, id = self.id; return, end
            
            self.msg = sprintf("variable %s must be of class [%s]", self.testVal_name, join(classOptions, ", "));
            self.isErr = ~any(ismember(Cls.allclasses(self.testVal), classOptions(:)));
            id = self.throw_check();
        end
        
        % Numeric
        function id = verifyNumeric(self)
            self.id = "RequiresNumeric";
            if ~self.doThrow, id = self.id; return, end
            
            self.msg = sprintf("requires a numeric value");
            self.isErr = ~isnumeric(self.testVal);
            id = self.throw_check();
        end
        
        function id = verifyPositive(self)
            self.id = "RequiresPositive";
            if ~self.doThrow, id = self.id; return, end
            
            self.msg = sprintf("variable %s must be positive", self.testVal_name);
            self.isErr = ~all(self.testVal >= 0);
            id = self.throw_check();
        end
        
        function id = verifyEqual(self, reqVal, location)
            self.id = "MustEqual";
            if ~self.doThrow, id = self.id; return, end
            
            self.msg = sprintf("%s must equal %s in %s", self.testVal, reqVal, location);
            self.isErr = self.testVal ~= reqVal;
            id = self.throw_check();
        end
        
        % File Handling
        function id = verifyFileOpens(self)
            self.id = "OpenableFile";
            if ~self.doThrow, id = self.id; return, end %%TODO: better way
            
            self.msg = sprintf("cannot open file %s", Prnt.path(self.testVal));
            fhndl = fopen(self.testVal);
            self.isErr = fhndl == -1;
            if ~self.isErr
                fclose(fhndl);
            end
            id = self.throw_check();
        end
    end
    
    %% Exception Makers
    methods (Access = private)
        function throwErr(self)
            errMsg = sprintf("%s %s", Except.reqFcn_trace, self.msg);
            fullID = self.fullID_make(self.id);
            err = MException(fullID, errMsg);
            throw(err);
        end
        
        function fullID = fullID_make(self, id)
             fullID = sprintf("%s:%s", self.component, id);
        end
    end
    methods (Static, Access = private)
        function reqFcn = reqFcn_trace(~)
            stack = dbstack;
            tracename = stack(end).name;
            shortnames = strrep(char(tracename), {'get.', 'set.'}, '');
            [~, shorterInd] = min(cellfun(@length, shortnames));
            reqFcn = string(shortnames(shorterInd));
        end
    end
end