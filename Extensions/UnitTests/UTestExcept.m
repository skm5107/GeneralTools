classdef UTestExcept < UTest
    
    properties (Constant)
        prefix = "Custom:"
        
        dimHndls = {"verifyDims", "verifyDims", "verifyDims"}
        dimFailIn = { [1;2;3], [1;2;3], [1;2;3] }
        dimFailTest = { {[1, 3]}, {[inf, 3]}, {[1, inf]} }
        
        dimPassIn = { [4,2,0;6,8,10], [4,2,0;6,8,10], [4,2,0;6,8,10] }
        dimPassTest = { {[2 ,3]}, {[inf, 3]}, {[2, inf]} }
    end
    
    properties (Constant)
        numHndls = {"verifyEqual", "verifyPositive"}
        numFailIn = { 10, -3 }
        numFailTest = { {12, "loc"}, {} }
        
        numPassIn = { -2, 3 }
        numPassTest = { {-2, "loc"}, {} }
    end
    
    properties (TestParameter)
        hndl = [UTestExcept.dimHndls, UTestExcept.numHndls];
        failIn = [UTestExcept.dimFailIn, UTestExcept.numFailIn];
        failTest = [UTestExcept.dimFailTest, UTestExcept.numFailTest];
        passIn = [UTestExcept.dimPassIn, UTestExcept.numPassIn];
        passTest = [UTestExcept.dimPassTest, UTestExcept.numPassTest];
    end
    
    methods (Test, ParameterCombination='sequential')
        function fail_check(err, hndl, failIn, failTest)
            actual = Except(failIn);
            fcnHndl = str2func(hndl);
            if ~isempty(failIn)
                err.verifyError(@()fcnHndl(actual, failTest{:}), Except.errID(hndl))
            else
                err.verifyError(@()fcnHndl(actual), Except.errID(hndl))
            end
        end
        
        function pass_check(pass, hndl, passIn, passTest)
            fcnHndl = str2func(hndl);
            if ~isempty(passIn)
                actual = fcnHndl(Except(passIn), passTest{:});
            else
                actual = fcnHndl(Except(passIn));
            end
            fullID = UTestExcept.fullID_make(actual);
            pass.verifyEqual(fullID, Except.errID(hndl))
        end        
    end
    
    methods (Static, Access = private)
        function fullID = fullID_make(actual)
            fullID = (UTestExcept.prefix + actual);
        end
    end
end