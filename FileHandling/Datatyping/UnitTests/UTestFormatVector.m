classdef UTestFormatVector < UTest
    properties (Constant, TestParameter)
        flds = {'formatVect', 'lineEnd', ...
                'formatSpec', 'idVect', ...
                'styleVect', 'parseVect'};

        custEnd = { "e", "[^\n]", ...
                    "%e%[^\n]", "e", ...
                    "", "" }     
                      
        custDate = { ["C" "{YYMM;}D"], "[^\n\r]", ...
                     "%C%{YYMM}D%[^\n\r]", ["C" "D"], ...
                     ["" "YYMM"], ["" ";"] }      

        custCat = { ["{**;}C" "r" "{|}c"], "", ...
                    "%{**}C%r%c", ["C" "r" "c"], ...
                    ["**" "" ""], [";" "" "|"] }
                
        custMany = { ["{:}d" "s" "{;}C" "{|}L"], [], ...
                     "%d%s%C%L%[^\n\r]", ["d" "s" "C" "L"], ...
                     ["" "" "" ""], [":" "" ";" "|"] }
    end
    
    %% Expected Passes
    methods (Test)
        function prop_custEnd(props)
            actual = FormatVector(UTestFormatVector.custEnd{1}, UTestFormatVector.custEnd{2});
            for ifld = 1:length(UTestFormatVector.flds)
                fld = UTestFormatVector.flds{ifld};
                props.verifyEqual(actual.(fld), UTestFormatVector.custEnd{ifld});
            end
            props.verifyEqual(height(actual.ref), length(UTestFormatVector.custEnd{1}));
        end
        
        function prop_custDate(props)
            actual = FormatVector(UTestFormatVector.custDate{1});
            for ifld = 1:length(UTestFormatVector.flds)
                fld = UTestFormatVector.flds{ifld};
                props.verifyEqual(actual.(fld), UTestFormatVector.custDate{ifld});
            end
            props.verifyEqual(height(actual.ref), length(UTestFormatVector.custDate{1}));
        end   
        
        function prop_custCat(props)
            actual = FormatVector(UTestFormatVector.custCat{1}, UTestFormatVector.custCat{2});
            for ifld = 1:length(UTestFormatVector.flds)
                fld = UTestFormatVector.flds{ifld};
                props.verifyEqual(actual.(fld), UTestFormatVector.custCat{ifld});
            end
            props.verifyEqual(height(actual.ref), length(UTestFormatVector.custCat{1}));
        end   

        function prop_custMany(props)
            actual = FormatVector(UTestFormatVector.custMany{1}, UTestFormatVector.custMany{2});
            for ifld = 1:length(UTestFormatVector.flds)
                fld = UTestFormatVector.flds{ifld};
                if fld ~= "lineEnd"
                    props.verifyEqual(actual.(fld), UTestFormatVector.custMany{ifld});
                else
                    props.verifyEqual(actual.(fld), "[^\n\r]");
                end
            end
            props.verifyEqual(height(actual.ref), length(UTestFormatVector.custMany{1}));
        end           
    end
end