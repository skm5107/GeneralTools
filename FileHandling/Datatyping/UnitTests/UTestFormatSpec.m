classdef UTestFormatSpec < UTest
    properties (Constant, TestParameter)
        flds = {'arginSpec', 'formatVect', 'lineEnd'};

        custEnd = { "%e%[^\n]", "e", "[^\n]" } 
                      
        custDate = { "%C%{YYMM;}D%[^\n\r]", ["C" "{YYMM;}D"], "[^\n\r]" }      

        custCat = { "%{**;}C%r%{|}c", ["{**;}C" "r" "{|}c"], "" }
                
        custMany = { "%{:}d%s%{;}C%{|}L%[^\n\r]", ["{:}d" "s" "{;}C" "{|}L"], "[^\n\r]" }
    end
    
    %% Expected Passes
    methods (Test)
        function prop_custEnd(props)
            actual = FormatSpec(UTestFormatSpec.custEnd{1});
            props.verifyEqual(actual.formatVect, UTestFormatSpec.custEnd{2});
            props.verifyEqual(actual.lineEnd, UTestFormatSpec.custEnd{3});
        end
        
        function prop_custDate(props)
            actual = FormatSpec(UTestFormatSpec.custDate{1});
            props.verifyEqual(actual.formatVect, UTestFormatSpec.custDate{2});
            props.verifyEqual(actual.lineEnd, UTestFormatSpec.custDate{3});
        end   
        
        function prop_custCat(props)
            actual = FormatSpec(UTestFormatSpec.custCat{1});
            props.verifyEqual(actual.formatVect, UTestFormatSpec.custCat{2});
            props.verifyEqual(actual.lineEnd, UTestFormatSpec.custCat{3});
        end   

        function prop_custMany(props)
            actual = FormatSpec(UTestFormatSpec.custMany{1});
            props.verifyEqual(actual.formatVect, UTestFormatSpec.custMany{2});
            props.verifyEqual(actual.lineEnd, UTestFormatSpec.custMany{3});
        end           
    end
end