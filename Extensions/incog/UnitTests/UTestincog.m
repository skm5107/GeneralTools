classdef UTestincog < UTest
    properties (Constant, Hidden)
        xValues = ["exMiss", "exNormal", "exEmpty", "exAutoMiss"];
        xTypes = {missing, "normalType", []};
        exMissing = multi(UTestincog.xValues, UTestincog.xTypes);
    end
    
    methods (Test)
        function miss_make(missMake)
            exMissing = UTestincog.exMissing;
            
            missMake.assertEqual(exMissing.values, num2cell(UTestincog.xValues));
            missMake.assertEqual(exMissing.types, [UTestincog.xTypes, {missing}]);
        end

        function values_cat(valuesCat)
            catVals = [UTestincog.exMissing, UTestincog.exMissing.values];
            
            valuesCat.assertEqual(catVals.values, ...
                num2cell([UTestincog.xValues, UTestincog.xValues]));
            valuesCat.assertEqual(catVals.types, ...
                [UTestincog.xTypes, repmat({missing}, [1 5])]);
        end
        
        function multi_cat(multiCat)
            exMissing = multi(UTestincog.xValues, UTestincog.xTypes);
            catMultis = [exMissing, exMissing];
            
            multiCat.assertEqual(catMultis.values, ...
                num2cell([UTestincog.xValues, UTestincog.xValues]));
            multiCat.assertEqual(catMultis.types, ...
                [UTestincog.xTypes, {missing}, UTestincog.xTypes, {missing}]);
        end
        
        function types_repl(replTypes)
            repl = [UTestincog.exMissing, UTestincog.exMissing.values];
            newV = "ThisIsNew";
            repl.types(3:5) = newV;
            
            replTypes.assertEqual(repl.values, ...
                num2cell([UTestincog.xValues, UTestincog.xValues]));
            replTypes.assertEqual(repl.types, ...
                {missing, "normalType", newV,  newV,  newV, missing, missing, missing});
        end
    end
    
    properties (Constant, Hidden)
        nValues = {"John Schmidt", categorical("John"), "Jacob", ["Jingleheimer" "Schmidt"]};
        nTypes = {"primary", ["given" "first"], "given" {"middle" "mid"}, categorical("family")};
    end
    
    methods (Test)
        function name_make(nameMake)
            name = multi(UTestincog.nValues, UTestincog.nTypes);
            
            nameMake.assertEqual(name.values, UTestincog.nValues);
            nameMake.assertEqual(name.types, UTestincog.nTypes);
        end
    end
end