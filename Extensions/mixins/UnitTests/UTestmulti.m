classdef UTestmulti < UTest
    properties (Constant, Access = private)
        nestval = {[1 2 3; 4 5 6], {"A" "B" {10 20}}, 'charStr'}
        nesttyp = {["num" "cell"] ["str" "cell"] "char"}
        nested = multi(UTestmulti.nestval, UTestmulti.nesttyp)
    end
        
    properties (Constant, TestParameter, Hidden)
        num_refs = {"(1,1:2)", "{1,3}(4)", ".num(3)"}
        type_refs = {'("cell")', "notRealType"}
    end
    
    methods (Test)
        function ref_nums(tester, num_refs)
            [isErr, exp] = values_expect(num_refs);
            if isErr
                tester.verifyError(@() callMulti(caller), exp, char(num_refs));
            else
                actual = callMulti(num_refs);
                tester.verifyEqual(actual, exp, char(num_refs));
            end
        end
    end
end

function [isErr, exp] = values_expect(num_refs)
    try 
        exp = eval("UTestmulti.nested.values" + num_refs);
        isErr = false;
    catch except
        exp = except.identifier;
        isErr = true;
    end
end

function actual = callMulti(caller)
    actual = eval("UTestmulti.nested" + caller);
end
