classdef UTestFormattedCsv < UTest
    %For ROSOUT: requires inserting text before #### in example file
    properties (Constant, Hidden)
        topCsv = fullfile("PCAMS_Analysis", "ExampleSrc", ...
            "RadPiper-01_0253_42CalVer_2019-03-20-12-57-08_U3O8")
        topHead = fullfile("PCAMS_Analysis", "PCAMS", "Constants", "headers", "tested")
        key = readtable(fullfile(UTestFormattedCsv.topCsv, "unittest.csv"))
    end

    properties (TestParameter)
        pathHead = UTestFormattedCsv.key.pathHead
        pathCsv = UTestFormattedCsv.key.pathCsv
        hgt = num2cell(UTestFormattedCsv.key.hgt)
        second_val = num2cell(UTestFormattedCsv.key.headSeq)
    end
    
    methods (Test, ParameterCombination = 'sequential')
        function checkRead(tester, pathHead, pathCsv, hgt)
            fileCsv = fullfile(UTestFormattedCsv.topCsv, pathCsv);
            fileHead = fullfile(UTestFormattedCsv.topHead, pathHead);
%             raw = readtable(fileCsv);
            raw = readtable(fileCsv, 'Delimiter', {',', '|'}, ...
                'HeaderLines', 0, ...
                'ReadVariableNames', true, 'PreserveVariableNames', true, ...
                'CommentStyle', '#');
           % raw = FormattedCsv(fileCsv, fileHead).run;
            tester.assertEqual(height(raw), hgt);
        end
    end
        
end