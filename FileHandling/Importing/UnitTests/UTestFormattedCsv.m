classdef UTestFormattedCsv < UTest

    properties (Constant)
        realPath = fullfile(UTest.topDir, "utest_example.csv");
        realPath_ncol = 8;
        Header = UTestFormattedCsv.head_load
        Raw = UTestFormattedCsv.raw_load
        
        exp = {'categorical', 'string', 'double', 'logical', 'datetime', 'double', 'cell', 'table'};
    end
    
    methods (Static, Access = private)  %%TODO: setup getters
        function Header = head_load
            [~, rawHead] = ImportedRaw(HeaderImporter(UTestFormattedCsv.realPath)).run;
            Header = ImportedHeader(rawHead);
        end
        
        function Raw = raw_load
            [~, Raw] = ImportedRaw(BodyImporter(UTestFormattedCsv.realPath, UTestFormattedCsv.realPath_ncol)).run;            
        end
    end
    
    methods (Test)
        function real_test(real)
            actual = FormattedCsv(UTestFormattedCsv.Raw, UTestFormattedCsv.Header).run;
            for icol = 1:length(UTestFormattedCsv.exp)
                real.verifyEqual(class(actual{:, icol}),UTestFormattedCsv.exp{icol});
            end
        end
        
    end
end