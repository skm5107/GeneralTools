classdef UTestStr < UTest
    properties (TestParameter)
        inputs = {{["ABC [EFG]" "XYZ (123) [EFG]"], ["[" "]"]}, ...
                  {["ABC [EFG]" "XYZ (123) [EFG]"], ["(" ")"]}};

        insides = {["EFG" "EFG"], ["" "123"]};
        outsides = {["ABC " "XYZ (123) "], ["ABC [EFG]" "XYZ  [EFG]"]};
    end
    
    methods (Test, ParameterCombination = "sequential")
        function test_inside(tester, inputs, insides)
            outputs = Str.getInside(inputs{:});
            tester.verifyEqual(outputs, insides);
        end
        
        function test_outside(tester, inputs, outsides)
            outputs = Str.getOutside(inputs{:});
            tester.verifyEqual(outputs, outsides);
        end
        
        function test_inout(tester, inputs, insides, outsides)
            [Ins, Outs] = Str.getInOut(inputs{:});
            tester.verifyEqual(Ins, insides);
            tester.verifyEqual(Outs, outsides);
        end
    end
end