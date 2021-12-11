classdef UTestFormattedCsv < UTest
    properties (Constant, Hidden)
        exCsv = fullfile(Fldr.getcurPath(mfilename("fullpath")), ...
            "example_data.csv")
        exHead = fullfile(Fldr.getcurPath(mfilename("fullpath")), ...
            "example_header.csv")
    end
    
    methods (Test)
        function checkwData1(checker)
            origWarn = warning("off", 'MATLAB:table:ModifiedAndSavedVarnames');
            act = FormattedCsv(UTestFormattedCsv.exCsv);
            act.headerRows = 1;
            act = act.run;
            checker.verifySize(act, [7,5])
            checker.verifyEqual(act.incld_cell(end), {'missing'})
            warning(origWarn)
        end
        
        function checkwData5(checker)
            origWarn = warning("off", 'MATLAB:table:ModifiedAndSavedVarnames');
            act = FormattedCsv(UTestFormattedCsv.exCsv);
            act = act.run;
            checker.verifySize(act, [3,5])
            checker.verifyEqual(act.incld_cell{end}, {'missing'})
            warning(origWarn)
        end        
        
        function checkHead(checker)
            origWarn = warning("off", 'MATLAB:table:ModifiedAndSavedVarnames');
            act = FormattedCsv(UTestFormattedCsv.exCsv, UTestFormattedCsv.exHead);
            act.rawSkipRows = 5; %skip the header in the example data file
            act = act.run;
            checker.verifySize(act, [3,5])
            checker.verifyEqual(act.separated_cat(2), categorical("Category-3"))
            warning(origWarn)
        end        
    end
        
end