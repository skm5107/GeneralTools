classdef UTestFlatTable < UTest
    properties (Constant, TestParameter)
        nested = {UTestFlatTable.nested_make};
        sz = {[2 9]};
        varNames = { {'name1_num1', 'name1_num2', ...
                      'name2_str3', 'name2_str4', 'name3', ...
                      'subsection_name4_num5', 'subsection_name4_num6', ...
                      'subsection_name4_str7', 'subsection_name4_str8'} };        
    end
    
    methods (Test)
        function nest_test(nst, nested, sz, varNames)
            actual = FlatTable(nested).run;
            nst.verifySize(actual, sz);
            nst.verifyEqual(actual.Properties.VariableNames, varNames);
        end
    end
    
    methods (Static, Access = private)
        function nested = nested_make
            name1 = table([1;2], [0.3, 0.4, 0.5; 0.6, 0.7, 0.8], 'VariableNames', {'num1', 'num2'});
            name2 = table(["abc"; "def"], ["A", "b"; "c", "d"], 'VariableNames', {'str3', 'str4'});
            nested = [table(name1), table(name2)];
            nested.name3 = [false; true];
            
            name4 = name1;
            name4.Properties.VariableNames = {'num5', 'num6'};
            name5 = name2;
            name5.Properties.VariableNames = {'str7', 'str8'};
            subsection = [table(name4), table(name5)];
            nested.subsection = subsection;                
        end
    end
end