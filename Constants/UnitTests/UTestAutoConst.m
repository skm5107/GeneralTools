classdef UTestAutoConst < UTest
    properties (Constant) %%TODO
        Ids = ConstIDs("gen", "UTest").run;
    end
    
    methods (Test)
        function pcams_test(pcams)
            actual = AutoConst(UTestAutoConst.Ids).run;
%             pcams.verifySize(actual.conv, [1 5])
        end
    end
end