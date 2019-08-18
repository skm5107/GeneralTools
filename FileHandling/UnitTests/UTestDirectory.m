classdef UTestDirectory < UTest
    properties (Constant)
        top_path = fullfile(UTest.topDir, "utest_example");
        topdir_nrow = 2;
        nAutoIgnore = 2 + 2;
    end
    
    %% Test Constructor
    % Checks resulting number of rows in actual.map from different subdir_maxlvl
    properties (Constant)
        map_nrows = [2, 5, 9, 10];
    end
    properties (TestParameter)
        subdir_lvl = num2cell(1:11);
    end
    
    methods (Test, ParameterCombination = 'exhaustive')
        function testConstructor(construct, subdir_lvl)
            actual = Directory(UTestDirectory.top_path, subdir_lvl).run;
            if subdir_lvl <= length(UTestDirectory.map_nrows)
                expect.map_nrows = UTestDirectory.map_nrows(subdir_lvl);
            else
                expect.map_nrows = UTestDirectory.map_nrows(end);
            end
            construct.verifyEqual(height(actual), expect.map_nrows);
        end
    end
    
    %% Setters & Getters %%TODO: fix
%     % Checks resulting number of rows in actual.map from different ignore_ and keep_ names
%     properties (TestParameter)
%         keep_names = [{}, {"level3a"}, {["level3a", "level3b"]}];
%         keep_namesPartial = [{}, {"vel3a"}];
%         
%         ignore_names = [{}, {"level1b"}, {"DoesNotExist"}, {["level1b", "DoesNotExist"]}];
%         ignore_namesPartial = [{}, {"1b"}, {"ignore"}, {"DoesNotExist"}, {["1b" "ignore"]}];
%     end
%     
%     methods (Test, ParameterCombination = 'exhaustive')
%         function testSize(sizes, keep_names, keep_namesPartial, ignore_names, ignore_namesPartial)
%             [~, actual] = Directory(UTestDirectory.top_path).run;
%             actual.keep_names = keep_names;
%             actual.keep_namesPartial = keep_namesPartial;
%             actual.ignore_names = ignore_names;
%             actual.ignore_namesPartial = ignore_namesPartial;
%             
%             expect = UTestDirectory.expect_set(actual);
%             sizes.verifyEqual(height(actual.topdir), UTestDirectory.topdir_nrow);
%             sizes.verifyEqual(height(actual.map), expect.map_nrow);
%             
%             sizes.verifyEqual(length(actual.keep_names), length(keep_names));
%             sizes.verifyEqual(length(actual.keep_namesPartial), length(keep_namesPartial));
%             sizes.verifyEqual(length(actual.ignore_names), length(ignore_names) + UTestDirectory.nAutoIgnore);
%             sizes.verifyEqual(length(actual.ignore_namesPartial), length(ignore_namesPartial));
%             
%         end
%     end
    
    methods (Static)
        function expect = expect_set(actual)
            if ~isempty(actual.keep_names) || ~isempty(actual.keep_namesPartial)
                expect.map_nrow = max(length(actual.keep_names), length(actual.keep_namesPartial));
            else
                len = max(length(actual.ignore_names), length(actual.ignore_namesPartial));
                ignore1 = ismember("DoesNotExist", [actual.ignore_names, actual.ignore_namesPartial]);
                expect.map_nrow = UTestDirector.map_maxrow - (len- ignore1);
            end
        end
    end
end