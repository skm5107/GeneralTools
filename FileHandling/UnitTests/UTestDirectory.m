classdef UTestDirectory < UTest
    properties (Constant)
        exPath = fullfile(Fldr.getcurPath(mfilename("fullpath")), ...
            "constants_example")
    end
    
    methods (Test)
        function szCheck(checker)
            act = Directory(UTestDirectory.exPath).run;
            expSz = [8, 6];
            checker.verifySize(act, expSz);
        end
        
        function entryCheck(checker)
            act = Directory(UTestDirectory.exPath).run;
            entry7 = "dog_tricks";
            checker.verifyEqual(act.filename(7), entry7);
        end
    end
end