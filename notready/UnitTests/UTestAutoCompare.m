classdef UTestAutoCompare < UTest
    properties (Constant)
        topPath = fullfile("PCAMS", "Validation", "UnitTests", "UTestEx");
        bagPath = fullfile(UTestAutoCompare.topPath, "RadPiper-01_0253_42CalVer_2019-03-20-12-57-08_U3O8");  
    end
    
    properties (Constant, TestParameter)
        filePaths = {UTestAutoCompare.exPaths_make};
        Importer = {ImportKey("PCAMS").run};
        ignoreCols = {"IgnoreNoColumns"};
    end
    
    methods (Static, Access = private)
        function filePaths = exPaths_make
            new = ["3-20-2019_ma_reverse_counts_data.csv";
                   "replicate.csv";
                   "data_table.csv"];
            filePaths = table();
            filePaths.new = fullfile(UTestAutoCompare.bagPath, new);
            filePaths.old = filePaths.new;
        end
    end
    
    methods (Test)
        function identical_test(iden, filePaths, Importer, ignoreCols)
            actual = AutoCompare(filePaths, Importer, ignoreCols).run;
            for icomp = 1:length(actual.comp)
                iden.verifyEmpty(actual.comp(icomp).nonMatches);
                iden.verifyTrue(actual.comp(icomp).isMatch);
            end
        end
    end
end