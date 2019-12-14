classdef UTestBodyImporter < UTest
    %% Constructor Arguments
    properties (Constant)
        defPath = [];
        defCol = [];
        defStart = 1;
        defEnd = inf;
    end
    properties (Constant, TestParameter)
        inPaths = {[], fullfile(UTest.topDir, "utest_example.csv"), ...
                       fullfile(UTest.topDir, "NotaRealFile.csv")};
        inVars = {[], Rand.btwn([1, 10], 1, 0)};
        inStarts = {[], Rand.btwn([1, 10], 1, 0)};
        inEnds = {[], Rand.btwn([1, 10], 1, 0)};
    end
    
    methods (Test, ParameterCombination = 'exhaustive')
        function argins(argP, inPaths, inVars, inStarts, inEnds)
            actual = BodyImporter(inPaths, inVars, inStarts, inEnds);
            
            [inPaths, inVars, inStarts, inEnds] = Val.empty_override({inPaths, inVars, inStarts, inEnds}, ...
                {UTestBodyImporter.defPath, ...
                UTestBodyImporter.defCol, ...
                UTestBodyImporter.defStart, ...
                UTestBodyImporter.defEnd});
            
            argP.verifyEqual(actual.path, inPaths);
            argP.verifyEqual(actual.nVars, inVars);
            argP.verifyEqual(actual.readRow_start, inStarts);
            argP.verifyEqual(actual.readRow_end, inEnds);
        end
    end
    
        %% Checking Setters and Getters
        properties (Constant, TestParameter)
            args = {'comment_style', '#';
                    'strip_char', '%';
                    'import_id', 's';
                    'delimiter', ";";
                    'text_type', "blank";
                    'lineEnd', "\n";
                    'print_tier', 1};
             props = UTestBodyImporter.args(:, 1);
             vals = UTestBodyImporter.args(:, 2);
        end
    
        methods (Test, ParameterCombination = 'sequential')
            function setters(sets, props, vals)
                actual = BodyImporter;
                actual.(props) = vals;
                if props == "import_id"
                    vals = string(vals);
                end
                
                sets.verifyEqual(actual.(props), vals);
                
                spec = "%" + join(repmat(actual.import_id, [1 actual.nVars]), "%") + ...
                       "%[" + actual.lineEnd + "]";
                sets.verifyEqual(actual.import_spec, spec)
            end
        end %%TODO redundant with Header and Body
end