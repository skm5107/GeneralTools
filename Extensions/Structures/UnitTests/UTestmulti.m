classdef UTestmulti < UTest
    properties (Constant, Hidden)
        zValues = {"John Schmidt", categorical("John"), "Jacob", ["Jingleheimer" "Schmidt"]};
        zLabels = {"primary", ["given" "first"], {"given", {"middle" "mid"}}, categorical("family")};
        name = multi(UTestmulti.zValues, UTestmulti.zLabels);
    end
    
    %% Referencing
    methods (Test)
        
        
        function num_paren(tester)
            tester.assertEqual(UTestmulti.name(1:2), UTestmulti.zValues(1:2))
        end
        
        function end_paren(tester)
            tester.assertEqual(UTestmulti.name(end-1), UTestmulti.zValues(end-1))
        end
        
        function end_brace(tester)
            tester.assertEqual(UTestmulti.name{end}, UTestmulti.zValues{end})
        end
        
        function log_ind(tester)
            ind = ([false false false true false]);
            tester.assertEqual(UTestmulti.name(ind), UTestmulti.zValues(ind))
        end
        
        function dot_ind(tester)
            tester.assertEqual(UTestmulti.name.first, UTestmulti.zValues{2:3})
        end
        
        function lookup_ind(tester)
            tester.assertEqual(UTestmulti.name("given"), UTestmulti.zValues(2:3))
        end
        
        function lookup_more(tester)
            [arg1, arg2] = UTestmulti.name{"given"};
            tester.assertEqual(arg1, UTestmulti.zValues{2})
            tester.assertEqual(arg2, UTestmulti.zValues{3})
        end
        
        function out_warn(tester)
            tester.assertWarning(@moreArgOuts, "multi:deal")
        end
        
        function brace_not(tester)
            tester.assertEmpty(UTestmulti.name{"mid"});
        end
        
        function brack_not(tester)
            tester.assertEmpty(UTestmulti.name(["middle" "mid"]));
        end
        
        function brace_both(tester)
            tester.assertEqual(UTestmulti.name({"middle" "mid"}), UTestmulti.zValues(3));
        end
        
        function brack_any(tester)
            tester.assertEqual(UTestmulti.name(["given" "unusedlabel"]), UTestmulti.zValues(2:3));
        end
        
        function label_struct(tester)
            exlabel.example = "A";
            structEx = multi({"exStr" "exampleStruct"}', {"str" exlabel});
            tester.assertEqual(structEx{exlabel}, "exampleStruct")
        end
        
        function ref_values(tester)
            example = multi(["Alpha", "Beta"]);
            tester.assertEqual(example.values(end), {"Beta"})
        end
    end
    
    %% Handle Missings
    properties (Constant, Hidden)
        xValues = ["exMiss", "exNormal", "exEmpty", "exAutoMiss"];
        xLabels = {missing, ["normalType1", "normalType2"], []};
        exMissing = multi(UTestmulti.xValues, UTestmulti.xLabels);
    end
    
    %% Concatenation & Replacement
    methods (Test)        
        function horz_cat(tester)
            catMultis = [UTestmulti.exMissing, UTestmulti.exMissing];
            
            tester.assertEqual(catMultis.values, ...
                num2cell([UTestmulti.xValues, UTestmulti.xValues]));
            tester.assertEqual(catMultis.labels, ...
                [UTestmulti.xLabels, {missing}, UTestmulti.xLabels, {missing}]);
        end
        
        function vert_cat(tester)
            demoDims = multi([1; 2; 3], {"input"; "as"; "vert"});
            vcat = [demoDims; demoDims];
            vals = num2cell(repmat([1 2 3], [2 1]), 1);
            lbls = num2cell(repmat(["input" "as" "vert"], [2 1]), 1);
            
            tester.assertEqual(vcat.values, vals);
            tester.assertEqual(vcat.labels, lbls);
        end
        
        function vals_vcat(tester)
            catVals = [UTestmulti.exMissing, UTestmulti.exMissing.values];
            
            tester.assertEqual(catVals.values, ...
                num2cell([UTestmulti.xValues, UTestmulti.xValues]));
            tester.assertEqual(catVals.labels, ...
                [UTestmulti.xLabels, repmat({missing}, [1 5])]);
        end
        
        function values_repl(tester)
            nme = UTestmulti.name;
            nme(1) = "Replaced Name";
            nme(end-1:end) = "Replaced 2";
            nme.values(2) = "Replaced Directly";
            tester.assertEqual(nme.values, ...
                {"Replaced Name", "Replaced Directly", "Replaced 2", "Replaced 2"});
        end

        function labels_repl(tester)
            repl.labels = UTestmulti.xLabels;
            repl.labels{2} = "ThisIsNew";
            
            tester.assertEqual(UTestmulti.exMissing.values, ...
                num2cell(UTestmulti.xValues));
            tester.assertEqual(repl.labels, ...
                {missing, "ThisIsNew", []});
        end
        
        function val_append(tester)
            nme = UTestmulti.name;
            nme(5:6) = "Appended Name";
            nme(end+1) = "Appended 2";
            tester.assertEqual(nme.values, ...
                [UTestmulti.zValues, {"Appended Name"}, {"Appended Name"}, {"Appended 2"}])
            tester.assertEqual(nme.labels, ...
                [UTestmulti.zLabels, {missing}, {missing}, {missing}])
        end
    end
    
    %% Initialization
    methods (Test)
        function name_init(tester)
            tester.assertEqual(UTestmulti.name.values, UTestmulti.zValues);
            tester.assertEqual(UTestmulti.name.labels, UTestmulti.zLabels);
        end
        
        function empty_init(tester)
            empt = multi;
            tester.assertSize(empt, [1 0])
        end
        
        function vert_init(tester)
            demoDims = multi([1; 2; 3], {"input"; "as"; "vert"});
            vcat = [demoDims; demoDims.values];
            vals = num2cell(repmat([1 2 3], [2 1]), 1);
            tester.assertEqual(vcat.values, vals);
        end
        
        function vert_switch(tester)
            demoDims = multi([1; 2; 3], {"input"; "as"; "vert"});
            tester.assertEqual(demoDims.values, {1 2 3});
            tester.assertEqual(demoDims.labels, {"input" "as" "vert"});
        end
    end
end

function moreArgOuts
    UTestmulti.name{"given"};
end

% classdef UTestmulti < UTest
%     properties (Constant, Access = private)
%         nestval = {[1 2 3; 4 5 6], {"A" "B" {10 20}}, 'charStr'}
%         nesttyp = {["num" "cell"] ["str" "cell"] "char"}
%         nested = multi(UTestmulti.nestval, UTestmulti.nesttyp)
%     end
%
%     properties (Constant, TestParameter, Hidden)
%         num_refs = {"(1,1:2)", "{1,3}(4)", ".num(3)"}
%         type_refs = {'("cell")', "notRealType"}
%     end
%
%     methods (Test)
%         function ref_nums(tester, num_refs)
%             [isErr, exp] = values_expect(num_refs);
%             if isErr
%                 tester.verifyError(@() callMulti(caller), exp, char(num_refs));
%             else
%                 actual = callMulti(num_refs);
%                 tester.verifyEqual(actual, exp, char(num_refs));
%             end
%         end
%     end
% end
%
% function [isErr, exp] = values_expect(num_refs)
%     try
%         exp = eval("UTestmulti.nested.values" + num_refs);
%         isErr = false;
%     catch except
%         exp = except.identifier;
%         isErr = true;
%     end
% end
%
% function actual = callMulti(caller)
%     actual = eval("UTestmulti.nested" + caller);
% end
