classdef UTestDate < UTest
    properties (Constant, TestParameter)
        input = {"NaT", "NAT", "missing", "empty", "", "NaN", "NAN", ".", ...
            "28-Feb-11", "3-Mar-91", "15-Dec-50", "2 February 1971", "October 6, 1862"};
        
        output = {NaT, NaT, NaT, NaT, NaT, NaT, NaT, NaT, ...
            datetime("28-Feb-2011"), datetime("3-Mar-1991"), datetime("15-Dec-2050"), datetime("2-Feb-1971"), datetime("6-Oct-1862")}; 
    end
    
    methods (Test, ParameterCombination='sequential')
        function read_test(tester, input, output)
            tester.verifyEqual(Date.read(input), output);
        end
    end
end