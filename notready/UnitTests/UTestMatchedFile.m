classdef UTestMatchedFile < UTest
    properties (Constant, TestParameter)
        newPath = {fullfile("UTest", "utest_wkey.csv")};
        oldPath = UTestMatchedFile.newPath;
    end
    
    properties (Constant)
        Importer = ImportKey("UTest").run;
    end
    
    methods (Test)
        function identical_test(iden, newPath, oldPath)
            [newTable, oldTable, ~] = MatchedFile(newPath, oldPath, UTestMatchedFile.Importer).run;
            iden.verifyEqual(newTable, oldTable);
        end
    end
end