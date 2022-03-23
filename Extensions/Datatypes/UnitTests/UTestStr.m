classdef UTestStr < UTest
    properties (TestParameter)
        getNumIns = {"1", "2.2", "12.3", "3.21", ...
                    "-1", "-2.2", "-12.3", "-3.21", ...
                    "+1", "+2.2", "+12.3", "+3.21", ...
                    "0"};
        getNumExps = {1, 2.2, 12.3, 3.21, ...
                      -1, -2.2, -12.3, -3.21, ...
                      1, 2.2, 12.3, 3.21, ...
                      0}
    end
    
    methods (Test, ParameterCombination = 'sequential')
        function testNums(tester, getNumIns, getNumExps)
            act = Str.getNums(getNumIns);
            exp = Str.getNums(getNumExps);
            tester.verifyEqual(act, exp);
        end
    end
end
       