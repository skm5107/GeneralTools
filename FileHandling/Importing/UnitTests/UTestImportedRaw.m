classdef UTestImportedRaw < UTest        
        properties (Constant)
            realPath = fullfile(UTest.topDir, "utest_exformatted.csv");
            
            realPath_ncol = 8;
            realPath_nrow = 5;
            realPath_sz = [UTestImportedRaw.realPath_nrow, UTestImportedRaw.realPath_ncol];
            
            badPath = fullfile(UTest.topDir, "NotaRealFile.csv");
        end
    
    %% File Path Pass & Fail
    methods (Test)
        function header_good(headP)
            [raw, actual] = ImportedRaw(HeaderImporter(UTestImportedRaw.realPath)).run;
            requested_height = range([actual.Info.readRow_start, actual.Info.readRow_end]) + 1;
            headP.verifySize(raw, [requested_height, actual.Info.nVars]);
        end
        
        function body_good(bodyP)
            importer = BodyImporter(UTestImportedRaw.realPath, UTestImportedRaw.realPath_ncol);
            actual = ImportedRaw(importer).run;
            bodyP.verifySize(actual, [UTestImportedRaw.realPath_nrow, UTestImportedRaw.realPath_ncol]);
        end

        function header_bad(headF)
            HeadInfo = HeaderImporter(UTestImportedRaw.badPath);
            headF.verifyError(@()ImportedRaw(HeadInfo).run, errID(Except, "verifyFileOpens"));
        end        
        
        function body_bad(bodyF)
            BodyInfo = BodyImporter(UTestImportedRaw.badPath);
            bodyF.verifyError(@()ImportedRaw(BodyInfo).run, errID(Except, "verifyFileOpens"));
        end
    end
end