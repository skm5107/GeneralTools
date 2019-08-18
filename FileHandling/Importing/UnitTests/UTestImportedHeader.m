classdef UTestImportedHeader < UTest        
    %% Size of Outputs
    properties (Constant)
        HeadInfo = HeaderImporter(fullfile(UTest.topDir, "Constants", "csvs.csv"));
        nVars = 8;
        varNames = ["filePath", "alias", "subName", "isPartial", ...
                    "headerNrows", "delimiter", "tierNum", "notes"]
        varUnits = repmat("", [1 UTestImportedHeader.nVars]);
        convert_vect = ["q" "{;}r" "q" "L" "d" "q" "d" "q"];
        varMult = ones(1, UTestImportedHeader.nVars);
        isSaved = true(1, UTestImportedHeader.nVars);
        notes = repmat("", [1 UTestImportedHeader.nVars]);
    end
    
    methods (Test)
        function check_vars(checks)
            [~, rawHead] = ImportedRaw(UTestImportedHeader.HeadInfo).run;
            actual = ImportedHeader(rawHead);
            checks.verifyEqual(actual.varNames, UTestImportedHeader.varNames);
            checks.verifyEqual(actual.varUnits, UTestImportedHeader.varUnits);
            checks.verifyEqual(actual.ConvertVect.formatVect, UTestImportedHeader.convert_vect);
            checks.verifyEqual(actual.varMult, UTestImportedHeader.varMult);
            checks.verifyEqual(actual.isSaved, UTestImportedHeader.isSaved);
            checks.verifyEqual(actual.notes, UTestImportedHeader.notes);
            
            checks.verifySize(actual.varDescs, [1 UTestImportedHeader.nVars]);
        end
    end
end