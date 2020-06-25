classdef UTestmulti1 < UTest
    properties (Constant, Hidden)
        mValues = ["exMiss", "exNormal", "exEmpty", "exAutoMiss"];
        mTypes = {missing, "normalType", []};
        exMissing = multi(UTestmulti1.mValues, UTestmulti1.mTypes);
    end
    
    methods (Test)
        function miss_make(missMake)
            exMissing = UTestmulti1.exMissing;
            
            missMake.assertEqual(exMissing.values, num2cell(UTestmulti1.mValues));
            missMake.assertEqual(exMissing.types, [UTestmulti1.mTypes, {missing}]);
        end

        function values_cat(valuesCat)
            catVals = [UTestmulti1.exMissing, UTestmulti1.exMissing.values];
            
            valuesCat.assertEqual(catVals.values, ...
                num2cell([UTestmulti1.mValues, UTestmulti1.mValues]));
            valuesCat.assertEqual(catVals.types, ...
                [UTestmulti1.mTypes, repmat({missing}, [1 5])]);
        end
        
        function multi_cat(multiCat)
            exMissing = multi(UTestmulti1.mValues, UTestmulti1.mTypes);
            catMultis = [exMissing, exMissing];
            
            multiCat.assertEqual(catMultis.values, ...
                num2cell([UTestmulti1.mValues, UTestmulti1.mValues]));
            multiCat.assertEqual(catMultis.types, ...
                [UTestmulti1.mTypes, {missing}, UTestmulti1.mTypes, {missing}]);
        end
        
        function types_repl(replTypes)
            repl = [UTestmulti1.exMissing, UTestmulti1.exMissing.values];
            newV = "ThisIsNew";
            repl.types(3:5) = newV;
            
            replTypes.assertEqual(repl.values, ...
                num2cell([UTestmulti1.mValues, UTestmulti1.mValues]));
            replTypes.assertEqual(repl.types, ...
                {missing, "normalType", newV,  newV,  newV, missing, missing, missing});
        end
    end
    
    properties (Constant, Hidden)
        xValues = {"John Schmidt", categorical("John"), "Jacob", ["Jingleheimer" "Schmidt"]};
        xTypes = {"primary", ["given" "first"], "given" {"middle" "mid"}, categorical("family")};
    end
    
    methods (Test)
        function name_make(nameMake)
            name = multi(UTestmulti1.xValues, UTestmulti1.xTypes);
            
            nameMake.assertEqual(name.values, UTestmulti1.xValues);
            nameMake.assertEqual(name.types, UTestmulti1.xTypes);
        end
    end
end