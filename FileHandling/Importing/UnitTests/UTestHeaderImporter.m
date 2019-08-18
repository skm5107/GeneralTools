classdef UTestHeaderImporter < UTest        
        properties (Constant)
            realPath = fullfile(UTest.topDir, "utest_exformatted.csv");
            realPath_ncol = 8;
            badPath = fullfile(UTest.topDir, "NotaRealFile.csv");
        end
    
    %% File Path Pass & Fail
    methods (Test)
        function path_good(pathP)
            actual = HeaderImporter(UTestHeaderImporter.realPath);
            pathP.verifyEqual(actual.nVars, UTestHeaderImporter.realPath_ncol);
        end
        
        function path_bad(pathF)
            actual = HeaderImporter(UTestHeaderImporter.badPath);
            pathF.verifyError(@()actual.nVars, errID(Except, "verifyFileOpens"));
        end
    end
    
    %% Changing Header Rows
    methods (Test)        
        function header_single(heads)
            actual = HeaderImporter;
            actual.headerRows = {'VariableNames'};
            heads.verifyEqual(actual.readRow_start, 1);
            heads.verifyEqual(actual.readRow_end, 1);
        end
        
        function header_none(head)
            actual = HeaderImporter;
            actual.headerRows = {};
            actual.readRow_start = 2;
            head.verifyEqual(actual.readRow_start, 2);
            head.verifyEqual(actual.readRow_end, 1);
        end
    end
    
    %% Checking Setters and Getters
    properties (Constant, TestParameter)
        args = {'comment_style', '#', UTestHeaderImporter.realPath_ncol;
                 'strip_char', '%', UTestHeaderImporter.realPath_ncol;
                 'import_id', 's', UTestHeaderImporter.realPath_ncol;
                 'delimiter', ";", 1;
                 'text_type', "blank", UTestHeaderImporter.realPath_ncol;
                 'lineEnd', '\n', UTestHeaderImporter.realPath_ncol;
                 'print_tier', 1, UTestHeaderImporter.realPath_ncol};
         props = UTestHeaderImporter.args(:, 1);
         vals = UTestHeaderImporter.args(:, 2);
         cols = UTestHeaderImporter.args(:, 3);
    end
    
    methods (Test, ParameterCombination = 'sequential')
        function setters(sets, props, vals, cols)
            actual = HeaderImporter(UTestHeaderImporter.realPath);
            actual.(props) = vals;
            if props == "import_id"
                vals = string(vals);
            end
            
            sets.verifyEqual(actual.(props), vals);
            sets.verifyEqual(actual.nVars, cols)
            
            spec = "%" + join(repmat(actual.import_id, [1 actual.nVars]), "%") + ...
                   "%[" + actual.lineEnd + "]";
            sets.verifyEqual(actual.import_spec, spec)
        end
    end
end