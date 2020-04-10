classdef UTestDirectory < UTest
    properties (Constant)
        exPath = UTestDirectory.findExPath()
    end
    
    methods (Static)
        function exPath = findExPath()
            herePath = which(fullfile("Navigating", "README.mlx"));
            topPath = fileparts(fileparts(herePath));
            exPath = fullfile(topPath, "Importing", "UnitTests", "constants_example");
        end
    end
end