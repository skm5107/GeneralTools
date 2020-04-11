classdef UTestMatchedDirMaps < UTest
    properties (Constant, TestParameter)
        newMap = {UTestMatchedDirMaps.exMap_make};
        oldMap = {Rand.shuffled(UTestMatchedDirMaps.newMap{:})};
    end
    
    methods (Static)
        function exMap = exMap_make
            name = ["ABC.m"; "ABC.csv"; "abc.xls"; "Example.m"; "Example.csv"; "Example.xls"];
            folders = [{["pathA" "pathB"]}; {"pathC"}; {""}; {["pathA" "pathC"]}; {["pathC" "ABC"]}; {["pathABC" "12"]}];
            isdir = zeros(size(name));
            exMap = table(name, folders, isdir);
        end
        
        function [oldName, isMatch] = isMatchFcn(newRow, oldRow)
            isMatch = newRow.name == oldRow.name;
            if isMatch
                oldName = Fldr.dirfullpath(oldRow);
            else
                oldName = string(missing);
            end
        end
    end
        
    methods (Test)
        function shuffled_test(shuff, newMap, oldMap)
            actual = MatchedDirMaps(newMap, oldMap, @UTestMatchedDirMaps.isMatchFcn).run;
            for ifile = 1:height(actual)
                shuff.verifyEqual(actual.new, actual.old)
            end
        end
    end
end