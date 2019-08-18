classdef UTestComparedTable < UTest
    properties (Constant, TestParameter)
        newTable = {cell2table({"a" "2|5" "0" "dc" "Feb-2" "Feb-22;Jan-1";
                                "b" "0.4|6" "TrUE" "xy" "Mar-20" "Mar-10;Oct-2"})}
        oldTable = UTestComparedTable.newTable;
    end
    
    methods (Test)
        function identical_test(iden, newTable, oldTable)
            actual = ComparedTable(newTable, oldTable).run;
            iden.verifyTrue(actual.isMatch);
            all(actual.diffTable)
        end
    end
end
    