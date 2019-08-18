classdef UTestImportKey < UTest
    %% Size of Outputs
    properties (Constant, Access = private) %%TODO: all unit tests all private
        files_sz = [9 9];
        headers_sz = [20 9];
        alias_sz = [2,2, 1,1,1, 3, 1,1, 1];
        folders_sz = [1,1,1, 1,1,1, 4,2, 1];
    end
    
    methods (Test)
        function sizes_check(szs)
            actual = ImportKey("UTest").run;
            szs.verifySize(actual.files, UTestImportKey.files_sz);
            szs.verifySize(actual.headers, UTestImportKey.headers_sz);
            
            for irow = 1:height(actual.files)
                szs.verifySize(actual.files.alias{irow}, [1 UTestImportKey.alias_sz(irow)]);
                szs.verifySize(actual.files.folders{irow}, [1 UTestImportKey.folders_sz(irow)]);
            end
        end
        
        function stnd_check(empty)
            empty.verifyTrue(all(UTest.checkClass));
        end
    end
end