classdef UTestincog < UTest
    properties (Constant, Hidden)
        xValues = ["exMiss", "exNormal", "exEmpty", "exAutoMiss"];
        xTypes = {missing, ["normalType1", "normalType2"], []};
        exMissing = multi(UTestincog.xValues, UTestincog.xTypes);
    end
    
    methods (Test)
        function miss_make(missMake)
            missMake.assertEqual(UTestincog.exMissing.values, ...
                num2cell(UTestincog.xValues));
            missMake.assertEqual(UTestincog.exMissing.types, ...
                [UTestincog.xTypes, {missing}]);
        end

        function values_cat(valuesCat)
            catVals = [UTestincog.exMissing, UTestincog.exMissing.values];
            
            valuesCat.assertEqual(catVals.values, ...
                num2cell([UTestincog.xValues, UTestincog.xValues]));
            valuesCat.assertEqual(catVals.types, ...
                [UTestincog.xTypes, repmat({missing}, [1 5])]);
        end
        
        function multi_cat(multiCat)
            catMultis = [UTestincog.exMissing, UTestincog.exMissing];
            
            multiCat.assertEqual(catMultis.values, ...
                num2cell([UTestincog.xValues, UTestincog.xValues]));
            multiCat.assertEqual(catMultis.types, ...
                [UTestincog.xTypes, {missing}, UTestincog.xTypes, {missing}]);
        end
        
        function types_repl(replTypes)
            repl.types = UTestincog.xTypes;
            repl.types{2} = "ThisIsNew";

            replTypes.assertEqual(UTestincog.exMissing.values, ...
                num2cell(UTestincog.xValues));
            replTypes.assertEqual(repl.types, ...
                {missing, "ThisIsNew", []});
        end
    end
    
    properties (Constant, Hidden)
        nValues = {"John Schmidt", categorical("John"), "Jacob", ["Jingleheimer" "Schmidt"]};
        nTypes = {"primary", ["given" "first"], "given" {"middle" "mid"}, categorical("family")};
    end
    
    methods (Test)
        function name_make(nameMake)
            name = multi(UTestincog.nValues, UTestincog.nTypes);
            name.types
            UTestincog.nTypes
            nameMake.assertEqual(name.values, UTestincog.nValues);
            nameMake.assertEqual(name.types, UTestincog.nTypes);
        end
    end
end