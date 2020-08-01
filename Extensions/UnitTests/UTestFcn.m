classdef UTestFcn < UTest
    properties (Constant, TestParameter)
        nests = { {"a" "b"},        {{"a" "b"}},        {{{{{{{{{"a" "b"}}}}}}}}} }
        nestsExp = {["a" "b"],      ["a" "b"],          ["a" "b"]};
        
        
        staggers = { {{"a" "b"} "c"},   {{{"a" "b"} "c"} "d"}, ...
                 {{{{{{{{{"a" "b"}, "C"}, "D"}, "E"}, "F"}, "G"}, "H"}, "I"}, "J"} }
             
       staggersExp = { ["a" "b" "c"], ["a" "b" "c" "d"], ["a" "b" "C" "D" "E" "F" "G" "H" "I" "J"] }
    end
    
    methods (Test)
        function nest_test(nest, nests, nestsExp)
            actual = Fcn.uncell(nests);
            nest.verifyEqual(actual, nestsExp)
        end
%         function stagger_test(stag, staggers, staggersExp)
%             actual = Fcn.uncell(staggers);
%             stag.verifyEqual(actual, staggersExp)
%         end        
    end
end