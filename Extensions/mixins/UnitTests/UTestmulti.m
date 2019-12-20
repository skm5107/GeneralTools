classdef UTestmulti < UTest
    properties (Constant, Access = private)
        nestval = {[1 2 3; 4 5 6], {"A" "B" {10 20}}, 'charStr'}
        nesttyp = {["num" "cell"] ["str" "cell"] "char"}
        nested = multi(UTestmulti.nestval, UTestmulti.nesttyp)
    end
        
    properties (Constant, TestParameter, Hidden)
        ref_num1 = {"2" "4" "1:end-1" ":"}
        ref_num2 = UTestmulti.ref_num1
        ref_num3 = UTestmulti.ref_num1
        ref_brack = {{'{}' '{}' ''}, {'{}' '{}' '()'}}
        ref_typ = {"num", "cell", "char", "notUsed"}
    end
    
    methods (Test)
        function ref_nums(tester, ref_num1, ref_num2, ref_num3, ref_brack)
            caller = caller_make(ref_num1, ref_num2, ref_num3, ref_brack);
            [isErr, exp] = values_expect(caller);
            if isErr
                tester.verifyError(@() callMulti(caller), exp, char(caller));
            else
                actual = callMulti(caller);
                tester.verifyEqual(actual, exp, char(caller));
            end
        end
    end
end


function caller = caller_make(ref_num1, ref_num2, ref_num3, ref_brack)
    call1 = ref_make(ref_num1, ref_brack{1});
    call2 = ref_make(ref_num2, ref_brack{2});
    call3 = ref_make(ref_num3, ref_brack{3});
    caller = call1 + call2 + call3;
end
    
function call = ref_make(ref_num, ref_brack)
    if ~isempty(ref_brack)
        call = ref_brack(1) + ref_num + ref_brack(2);
    else
        call = "";
    end
end

function [isErr, exp] = values_expect(caller)
    try 
        exp = eval("UTestmulti.nested.values" + caller);
        isErr = false;
    catch except
        exp = except.identifier;
        isErr = true;
    end
end

function actual = callMulti(caller)
    actual = eval("UTestmulti.nested" + caller);
end
