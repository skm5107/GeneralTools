classdef UTestNum < UTest
    properties (TestParameter)
        commas = {1, 12, 123, 1234, 12345, 123456, ...
                  1234567, 12345678, 123456789, ...
                  1.0, 12.3, 123.45, 1234.567, 12345.6789, 123456.7890}
        decimals = {0, 0, 0, 0, 0, 0, ...
                    1, 2, 3, ...
                    1, 1, 3, 4, 5, 4}
        answers = {"1", "12", "123", "1,234", "12,345", "123,456", ...
                   "1,234,567.0", "12,345,678.00", "123,456,789.000", ...
                   "1.0", "12.3", "123.450", "1,234.5670", "12,345.67890", "123,456.7890"}
    end
    
    methods (Test, ParameterCombination = 'sequential')
        function testComma(checker, commas, decimals, answers)
            act = Num.insertCommas(commas, decimals);
            exp = answers;
            checker.verifyEqual(act, exp);
        end
    end
end
       