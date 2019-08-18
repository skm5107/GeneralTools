classdef UTestFullPath < UTest
    properties (Constant)
        topPath = "path1/path2/pathTop";
        exMap = UTestFullPath.exMap_make;
    end
    
    methods (Static, Access = private)
        function exMap = exMap_make
            name = ["ABC.csv"; "ABC.xls"; "abc.csv"; "abc.xls"; "Example.m"];
            folders = [""; "pathA/pathB"; "pathA/pathB"; "pathC/pathD"; "pathC"];
            isdir = zeros(size(name));
            exMap = table(name, folders, isdir);
        end
    end
end