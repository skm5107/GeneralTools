classdef UTestFormatter < UTest
    properties (Constant, Access = private)
        catsOnly = {{"cat1"; "CAT2"; "3Cat"}, "C", ...
                    {categorical("cat1"); categorical("CAT2"); categorical("3Cat")}}
        numsOnly = {{"99"; "-1.23"; "NaN"; "str"; "0"}, "f", ...
                    {99;    -1.23;   NaN;   NaN;   0}}

        strSplit = {{"str1A str1B"; "STR2A"; "3StrA 3StrB 3StrC"}, "q{ }", ...
                     {["str1A", "str1B"]; "STR2A"; ["3StrA", "3StrB", "3StrC"]}}
        numsSplit = {{"99|0.01"; "-1.23"; "NaN|2"; "str|cat"; "0.05|NaN"; "NaN"}, "d{|}", ...
                     {[99 0.01]; -1.23; [NaN 2]; [NaN NaN]; [0.05 NaN]; NaN}}
                 
        clocksSplitStyle = {{"1-Jan-1970"; "22-Feb-2050; 29-Dec-1999"}, "D (dd-MM-yyyy) {;}", ...
                       {datetime("1-Jan-1970", "InputFormat", "dd-MM-yyyy"); [datetime("22-Feb-2050", "InputFormat", "dd-MM-yyyy"), datetime("29-Dec-1999", "InputFormat", "dd-MM-yyyy")]}}
                         
    end
    
    properties (TestParameter)
        inputs = {UTestFormatter.catsOnly, ...
                  UTestFormatter.numsOnly, ...
                  UTestFormatter.strSplit, ...
                  UTestFormatter.numsSplit, ...
                  UTestFormatter.clocksSplitStyle}
    end
    
    methods (Test)
        function inits(checker, inputs)
            Spec = FormatSpec(inputs{2});
            act = Formatter(inputs{1}, Spec).run;
            checker.assertEqual(act, inputs{3});
        end
    end
end