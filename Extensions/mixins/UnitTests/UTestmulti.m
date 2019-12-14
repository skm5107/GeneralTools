classdef UTestmulti < UTest
    %% Typing
    methods (Test)
        function typed_full(tester)
            act = multi(["a" "b" "c"], ["AA" "BB" "CC"]);
            expect = {"AA" "BB" "CC"};
            tester.verifyEqual(act.types, expect);
        end
        
        function typed_partial(tester)
            act = multi(["a" "b" "c"], ["AA" "BB"]);
            expect = {"AA" "BB" missing};
            tester.verifyEqual(act.types, expect);
        end
        
        function typed_none(tester)
            act = multi(["a" "b" "c"]);
            expect = repmat({missing}, [1,3]);
            tester.verifyEqual(act.types, expect);
        end
    end
    
    %% Referencing
    properties (Constant, Access = private)
        values = values_load()
        types = {"primary", ["given" "first"], {"given" {"middle" "mid"}}, categorical("family")}
        name = multi(UTestmulti.values, UTestmulti.types)
    end
    
    methods (Test)
        function type_anyOf(tester)
            givens = UTestmulti.name(["given" "unusedType"]);
            tester.verifyEqual(givens, UTestmulti.values(2:3))
        end
        
        function type_both(tester)
            middle = UTestmulti.name({"middle" "mid"});
            tester.verifyEqual(middle, UTestmulti.values(3))
        end
        
        function type_woBoth(tester)
            doesntWork = UTestmulti.name("middle");
            tester.verifyEqual(doesntWork, cell.empty(1,0))
        end
        
        function type_notString(tester)
            family = UTestmulti.name(categorical("family"));
            tester.verifyEqual(family{:}, UTestmulti.values{4})
        end
    end
    
    methods (Test)
        function struct_allVals(tester)
            vals = UTestmulti.name.values;
            tester.verifyEqual(vals, UTestmulti.values);
        end
        
        function struct_parenVal(tester)
            val = UTestmulti.name.values(3);
            tester.verifyEqual(val, UTestmulti.values(3));
        end
        
        function struct_parensVals(tester)
            vals = UTestmulti.name.values([1,2]);
            tester.verifyEqual(vals, UTestmulti.values(1:2));
        end
        
        function struct_cellVal(tester)
            val = UTestmulti.name.values{3};
            tester.verifyEqual(val, UTestmulti.values{3});
        end
        
        function struct_cellsVals(tester)
            [val1, val2] = UTestmulti.name.values{[1,2]};
            tester.verifyEqual(val1, UTestmulti.values{1});
            tester.verifyEqual(val2, UTestmulti.values{2});
        end
    end
    
    methods (Test)
        function struct_allTypes(tester)
            typs = UTestmulti.name.types;
            tester.verifyEqual(typs, UTestmulti.types);
        end
        
        function struct_parenType(tester)
            typs = UTestmulti.name.types(2);
            tester.verifyEqual(typs{:}, UTestmulti.types{2});
        end
        
        function struct_parensTypes(tester)
            typs = UTestmulti.name.types([1,4]);
            tester.verifyEqual(typs, UTestmulti.types([1,4]));
        end
        
        function struct_cellType(tester)
            typ = UTestmulti.name.types{2};
            tester.verifyEqual(typ, UTestmulti.types{2});
        end
        
        function struct_cellsTypes(tester)
            [typ1, typ2] = UTestmulti.name.types{[1,4]};
            tester.verifyEqual({typ1, typ2}, UTestmulti.types([1,4]));
        end
    end
    
    methods (Test)
        function dot_single(tester)
            first = UTestmulti.name.first;
            tester.verifyEqual(first, categorical("John"));
        end
        
        function dot_multi(tester)
            [j, jj] = UTestmulti.name.given;
            tester.verifyEqual(j, UTestmulti.values{2});
            tester.verifyEqual(jj, UTestmulti.values{3});
        end
    end
    
    methods (Test)
        function num_paren(tester)
            byInd = UTestmulti.name(3);
            tester.verifyEqual(byInd{:}, UTestmulti.values{3});
        end
        
        function nums_parens(tester)
            byInds = UTestmulti.name([2, 4]);
            tester.verifyEqual(byInds, UTestmulti.values([2,4]));
        end
        
        function num_cell(tester)
            byInd = UTestmulti.name{4};
            tester.verifyEqual(byInd, UTestmulti.values{4});
        end
        
        function nums_cells(tester)
            [num1, num2] = UTestmulti.name{[1, 4]};
            tester.verifyEqual(num1, UTestmulti.name{1});
            tester.verifyEqual(num2, UTestmulti.name{4});
        end
    end
    
    methods (Test)
        function end_paren(tester)
            ender = UTestmulti.name(end);
            tester.verifyEqual(ender, UTestmulti.name(4));
        end
        
        function ends_parens(tester)
            enders = UTestmulti.name(1:end-3);
            tester.verifyEqual(enders{:}, UTestmulti.name{1});
        end
        
        function end_cell(tester)
            ender = UTestmulti.name{end};
            tester.verifyEqual(ender, UTestmulti.name{4});
        end
        
        function ends_cells(tester)
            [e1, e2] = UTestmulti.name{end-1:end};
            tester.verifyEqual(e1, UTestmulti.values{3});
            tester.verifyEqual(e2, UTestmulti.values{4});
        end
    end
    
    
    %% Assigning
    methods (Test)
        function repl_num(tester)
            temp = UTestmulti.name;
            temp(1) = "Replaced Name";
            tester.verifyEqual(temp.values{1}, "Replaced Name");
        end
        
        function repls_nums(tester)
            temp = UTestmulti.name;
            temp(1:2) = "Replaced Name";
            tester.verifyEqual(temp.values([1,2]), {"Replaced Name", "Replaced Name"});
        end
        
        function repls_all(tester)
            temp = UTestmulti.name;
            temp(:) = "Replaced Name";
            expect = num2cell(repmat("Replaced Name", [1,4]));
            tester.verifyEqual(temp.values, expect);
        end
        
        function repl_type(tester)
            temp = UTestmulti.name;
            temp.types(3) = "NewType";
            tester.verifyEqual(temp.types{4}, categorical("family"));
            tester.verifyEqual(temp.types{3}, "NewType");
        end
        
        function repl_allTypes(tester)
            temp = UTestmulti.name;
            temp.types(:) = "NewType";
            expect = num2cell(repmat("NewType", [1,4]));
            tester.verifyEqual(temp.types, expect);
        end
    end
    
    methods (Test)
        function append_paren(tester)
            temp = UTestmulti.name;
            temp(5) = "Appended Name";
            tester.verifyEqual(temp{5}, "Appended Name");
        end
        
        function appends_parens(tester)
            temp = UTestmulti.name;
            temp(5:6) = "Appended Name";
            expect = num2cell(repmat("Appended Name", [1,2]));
            tester.verifyEqual(temp{5:6}, expect);
        end
        
        function append_cell(tester)
            temp = UTestmulti.name;
            temp{5} = "Appended Name";
            tester.verifyEqual(temp(5), {{"Appended Name"}}); %#ok<STRSCALR>
        end
        
        function append_end(tester)
            temp = UTestmulti.name;
            temp(end+1) = "Appended Name";
            tester.verifyEqual(temp{end}, "Appended Name");
        end
    end
    
    %% Concatenation
    methods (Test)
        function hcat_multi(tester)
            temp = UTestmulti.name;
            act = [temp, temp];
            tester.verifyLength(act, length(temp)*2);
            tester.verifyEqual(act(5), temp(1));
            tester.verifyEqual(act.types(7), temp.types(3));
        end
        
        function hcat_values(tester)
            temp = UTestmulti.name;
            act = [temp, temp.values];
            tester.verifyLength(act, length(temp)*2);
            tester.verifyEqual(act(5), temp(1));
            tester.verifyEqual(act.types{6}, missing);
        end
        
        function vcat_multi(tester)
            temp = UTestmulti.name;
            act = [temp; temp];
            
            tester.verifyEqual(act.values{3}, [UTestmulti.values{3}; UTestmulti.values{3}]);
            hgts_val = cellfun(@(iact) size(iact, 1), act.values);
            tester.verifyTrue(all(hgts_val == 2));
            
            tester.verifyEqual(act.types{1}, [UTestmulti.types{1}; UTestmulti.types{1}]);
            hgts_types = cellfun(@(iact) size(iact, 1), act.types);
            tester.verifyTrue(all(hgts_types == 2));
        end
        
        function vcat_values(tester)
            temp = UTestmulti.name;
            act = [temp; temp.values];
            
            tester.verifyEqual(act.values{1}, [UTestmulti.values{1}; UTestmulti.values{1}]);
            hgts_val = cellfun(@(iact) size(iact, 1), act.values);
            tester.verifyTrue(all(hgts_val == 2));
            
            tester.verifyEqual(act.types{1}, UTestmulti.types{1});
            hgts_types = cellfun(@(iact) size(iact, 1), act.types);
            tester.verifyTrue(all(hgts_types == 1));
        end
    end
    
    %% Static Methods
    methods (Test)
        function class_check(tester)
            number = {"2" ["3" "4"]};
            output = multi.classCheck(number, "double");
            tester.verifyClass([output{:}], "double");
        end
        
        function class_error(tester)
            tester.verifyError(@clsErr, 'MATLAB:invalidConversion')
        end
    end
end

function values = values_load()
    primary = "John Schmidt";
    first = categorical("John");
    middle = "Jacob";
    last = ["Jingleheimer" "Schmidt"];
    values = {primary, first, middle, last};
end

function out = clsErr()
    out = multi.classCheck({"2" ["3" "4"]}, "struct");
end
