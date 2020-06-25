classdef UTestmulti < UTest
    properties (Constant, Hidden)
        zValues = {"John Schmidt", categorical("John"), "Jacob", ["Jingleheimer" "Schmidt"]};
        zLabels = {"primary", ["given" "first"], {"given", {"middle" "mid"}}, categorical("family")};
        name = multi(UTestmulti.zValues, UTestmulti.zLabels);
    end
    
    methods (Test)
        function name_make(nameMake)
            nameMake.assertEqual(UTestmulti.name.values, UTestmulti.zValues);
            nameMake.assertEqual(UTestmulti.name.labels, UTestmulti.zLabels);
        end
        
        function num_paren(parenNum)
            parenNum.assertEqual(UTestmulti.name(1:2)', UTestmulti.zValues(1:2)) %shouldn't need transpose
        end
        function end_paren(parenEnd)
            parenEnd.assertEqual(UTestmulti.name(end-1)', UTestmulti.zValues(end-1))  %shouldn't need transpose
        end
        
        function end_brace(braceEnd)
            braceEnd.assertEqual(UTestmulti.name{end}, UTestmulti.zValues{end})
        end
        
        function log_ind(indLog)
            ind = ([false false false true false]);
            indLog.assertEqual(UTestmulti.name(ind), UTestmulti.zValues(ind))
        end
        
        function dot_ind(indDot)
            indDot.assertEqual(UTestmulti.name.first, UTestmulti.zValues{2:3})
        end
        
        function lookup_ind(indLook)
            indLook.assertEqual(UTestmulti.name("given")', UTestmulti.zValues(2:3))
        end
        
        function lookup_more(moreLook)
            [arg1, arg2] = UTestmulti.name{"given"};
            moreLook.assertEqual(arg1, UTestmulti.zValues{2})
            moreLook.assertEqual(arg2, UTestmulti.zValues{3})
        end
        
        function out_warn(warnOut)
            warnOut.assertWarning(@moreArgOuts, "multi:deal")
        end
        
        function brace_not(failBrace)
            failBrace.assertEmpty(UTestmulti.name{"mid"});
        end
        
                function brack_not(failBrack)
                    failBrack.assertEmpty(UTestmulti.name(["middle" "mid"]));
                end
        
        function brace_both(bothBrace)
            bothBrace.assertEqual(UTestmulti.name({"middle" "mid"}), UTestmulti.zValues(3));
        end
        
        function brack_any(anyBrack)
            anyBrack.assertEqual(UTestmulti.name(["given" "unusedlabel"])', UTestmulti.zValues(2:3));
        end
        
        function label_struct(structLbl)
            exlabel.example = "A";
            structEx = multi({"exStr" "exampleStruct"}', {"str" exlabel});
            structLbl.assertEqual(structEx{exlabel}, "exampleStruct")
        end
        
        function ref_values(valsRef)
            example = multi(["Alpha", "Beta"]);
            valsRef.assertEqual(example.values(end), {"Beta"})
        end
    end
    
    properties (Constant, Hidden)
        xValues = ["exMiss", "exNormal", "exEmpty", "exAutoMiss"];
        xLabels = {missing, ["normalType1", "normalType2"], []};
        exMissing = multi(UTestmulti.xValues, UTestmulti.xLabels);
    end
    
    methods (Test)
        function miss_make(missMake)
            missMake.assertEqual(UTestmulti.exMissing.values, ...
                num2cell(UTestmulti.xValues));
            missMake.assertEqual(UTestmulti.exMissing.labels, ...
                [UTestmulti.xLabels, {missing}]);
        end
        
        function values_cat(valuesCat)
            catVals = [UTestmulti.exMissing, UTestmulti.exMissing.values];
            
            valuesCat.assertEqual(catVals.values, ...
                num2cell([UTestmulti.xValues, UTestmulti.xValues]));
            valuesCat.assertEqual(catVals.labels, ...
                [UTestmulti.xLabels, repmat({missing}, [1 5])]);
        end
        
        function multi_cat(multiCat)
            catMultis = [UTestmulti.exMissing, UTestmulti.exMissing];
            
            multiCat.assertEqual(catMultis.values, ...
                num2cell([UTestmulti.xValues, UTestmulti.xValues]));
            multiCat.assertEqual(catMultis.labels, ...
                [UTestmulti.xLabels, {missing}, UTestmulti.xLabels, {missing}]);
        end
        
        function labels_repl(replLabels)
            repl.labels = UTestmulti.xLabels;
            repl.labels{2} = "ThisIsNew";
            
            replLabels.assertEqual(UTestmulti.exMissing.values, ...
                num2cell(UTestmulti.xValues));
            replLabels.assertEqual(repl.labels, ...
                {missing, "ThisIsNew", []});
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
