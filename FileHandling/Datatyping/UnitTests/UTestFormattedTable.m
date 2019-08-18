classdef UTestFormattedTable < UTest
    %%TODO more?
    properties (Constant)
        rowsWithGoodLogicals = {"a" "2|5" "0" "dc" "Feb-2" "Feb-22;Jan-1";
                                "b" "0.4|6" "TrUE" "xy" "Mar-20" "Mar-10;Oct-2"};
        nanLogicalRow = cellstr({"c" "1.1|7" "NaN" "mn" "Dec-31" "Dec-30;Nov-3"});
        FormatVect = FormatVector(["{;}C" "{|}d" "L" "s" "{M-dd}D" "{M-dd;}D"]);
    end
    
    properties (Constant, TestParameter)       
        inLogical = {{ cellstr(UTestFormattedTable.rowsWithGoodLogicals), ...
                      UTestFormattedTable.FormatVect }};
        expLogical = {{ categorical("a"), 5, false, "dc" datetime("Feb-2", 'InputFormat', "M-dd");
                       categorical("b"), 6, true, "xy", datetime("Mar-20", 'InputFormat', "M-dd") }};
        
        
        inNaN = {{ vertcat(UTestFormattedTable.rowsWithGoodLogicals, UTestFormattedTable.nanLogicalRow), ...
                  UTestFormattedTable.FormatVect }};
        expNaN = {{ categorical("a"), 5, 0, "dc" datetime("Feb-2", 'InputFormat', "M-dd");
                   categorical("b"), 6, 1 "xy", datetime("Mar-20", 'InputFormat', "M-dd");
                   categorical("c"), 7, NaN, "mn", datetime("Dec-31", 'InputFormat', "M-dd") }};
    end
    
    %% Expected Passes
    methods (Test)
        function passAllLogicals(passes, inLogical, expLogical)
            actual = FormattedTable(inLogical{:}).run;
            Var = expLogical; %sets variable names to VarN
            passes.verifyEqual(actual, cell2table(Var));
        end
        function pass1NaN(passes, inNaN, expNaN)
            actual = FormattedTable(inNaN{:}).run;
            Var = expNaN; %sets variable names to VarN
            passes.verifyEqual(actual, cell2table(Var));
        end        
    end
end