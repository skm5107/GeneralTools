classdef UTestFormatSpec < UTest
    properties (Constant, Access = private)
        typeOnly = {["%q" "%d" "%C" "%T"], ...
                    ["%q" "%d" "%C" "%T"], ...
                    [""   ""   ""   ""], ...
                    [""   ""   ""   ""]};
        typeSplit = {["%C{;}" "%f{|}" "%u"], ...
                     ["%C"    "%f"    "%u"], ...
                     [";"     "|"     ""], ...
                     [""      ""      ""]}
        typeStyle = {["%d(style)" "%g"], ...
                     ["%d"        "%g"], ...
                     [""          ""], ...
                     ["style"     ""]}
        allSpecs = {"%T{;}(DDMM)", ...
                    "%T", ...
                    ";", ...
                    "DDMM"}
    end
    
    properties (TestParameter)
        inputs = {UTestFormatSpec.typeOnly, ...
                  UTestFormatSpec.typeSplit, ...
                  UTestFormatSpec.typeStyle, ...
                  UTestFormatSpec.allSpecs}
        flds = {{"typeSpec", 2}, ...
                {"splitSpec", 3}, ...
                {"styleSpec", 4}}
    end
    
    methods (Test)
        function inits(checker, inputs)
            act = FormatSpec(inputs{1});
            checker.assertEqual(act.typeSpec, inputs{2});
            checker.assertEqual(act.splitSpec, inputs{3})
            checker.assertEqual(act.styleSpec, inputs{4});
        end
        
        function lengths(checker, inputs)
            act = FormatSpec(inputs{1});
            checker.assertEqual(length(act), length(inputs{1}))
        end
        
        function fieldrefs(checker, inputs, flds)
            act = FormatSpec(inputs{1});
            actRef = act.(flds{1});
            expRef = inputs{flds{2}};
            checker.assertEqual(actRef, expRef);
        end
        
        function indrefs(checker, inputs)
            act = FormatSpec(inputs{1});
           for iind = 1:length(inputs{1})
               actRef = act(iind);
               expRef = inputs{1}(iind);
               exp = FormatSpec(expRef);
               checker.assertEqual(actRef, exp);
           end
        end
    end
end