classdef UTestPrnt < UTest
    properties (Constant, TestParameter)
        vect = { "a", "a ", " a", " a ", ...
                  'a', ' a', 'a ', ' a ', ...
                  "AB C ", " A BC", " A B C ", ...
                  [1 2 3], [-1; -20; -300], [-0.01; 2000; 333.3; -44.444] };        
        parser = {" " "," " |", ", ", ", |", [], {}};
    end
    
    properties (Constant)
        expFill = { 'a', 'a', 'a', 'a', ...
                    'a', 'a', 'a', 'a', ...
                    "AB C", "A BC", "A B C", ...
                    "1%2%3", "-1%-20%-300", "-0.01%2000%333.3%-44.444" };
    end
    
    methods (Test, ParameterCombination = 'exhaustive')
        function vectprint_test(vpf, vect)
            actual = Prnt.vectprintf(vect);
            exp = UTestPrnt.expect_make(vect);
            vpf.verifyEqual(actual, exp)
        end     
        
        function vectprintparser_test(vpfp, vect, parser)
            actual = Prnt.vectprintf(vect, parser);
            exp = UTestPrnt.expect_make(vect, parser);
            vpfp.verifyEqual(actual, exp)
        end             
    end
    
    methods (Static, Access = private)
        function exp = expect_make(vect, parser)
            if nargin < 2 || isempty(parser)
                parser = " ";
            end
            
            vectInd = cellfun(@(elem) isequaln(elem, vect), UTestPrnt.vect);
            expFill = UTestPrnt.expFill{vectInd};
            
            exp = char(strrep(expFill, "%", parser));
        end
    end
end