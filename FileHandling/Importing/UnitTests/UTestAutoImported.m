classdef UTestAutoImported < UTest
    properties (Constant)
        realPath = fullfile(UTest.topDir, "utest_example.csv");
        exp = {'categorical', 'string', 'double', 'logical', 'datetime', 'double', 'cell', 'table'};
    end
    
    methods (Test)
        function real_test(real)
            actual = AutoImported(UTestAutoImported.realPath).run;
            for icol = 1:length(UTestAutoImported.exp)
                real.verifyEqual(class(actual{:, icol}), UTestAutoImported.exp{icol});
            end            
        end
    end
end