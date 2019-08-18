classdef UTestFormatKey < UTest
    properties (TestParameter)
        lookupArgs = { {"d", "typeID"};
                       {"d", "typeID", "finalID"};
                       {"@", "varType"};
                       {"D",'finalID', "finalID"};
                       {"T",'typeID', "typeID"};
                       {"r",'typeID'};
                       {"L",'finalID'};
                       {"C",{'typeID', 'finalID'}, "finalID"} };
                   
        expSizes = { [2, UTestFormatKey.nCols];
                     [2, 1];
                     [0, UTestFormatKey.nCols];
                     [1, 1];
                     [1, 1];
                     [0, UTestFormatKey.nCols];
                     [1, UTestFormatKey.nCols];
                     [1, 1] };

        warnArgs = { {"double", "varType", "NotACol"};
                     {"NotaVar", "importID", "NotACol"};
                     {"NotaVar", "NotACol", "finalID"} };
             
        warnSizes = { [2, 0];
                      [0, 0];
                      [0, 1] }; 
    end
    
    properties (Constant)
        nCols = 6;
    end
    
    methods (Test, ParameterCombination='sequential')
        function noWarn_tests(noWarn, lookupArgs, expSizes)
            actual = Key.lookup(FormatKey.key, lookupArgs{:});
            noWarn.verifySize(actual, expSizes);
        end

        function warn_tests(warn, warnArgs, warnSizes)
            actual = warn.verifyWarning(@() Key.lookup(FormatKey.key, warnArgs{:}), "");
            warn.verifySize(actual, warnSizes);
        end            
    end
    
end