classdef UTest < matlab.unittest.TestCase
    properties (SetAccess = private, Hidden)
        testclassName (1,1) string = missing
        testclassHndl function_handle = function_handle.empty
    end
    
    properties (Constant, Access = protected)
        filePre = "UTest";
        fileExt = ".m";
        topDir = "UTest";
        emptyVal = ".empty";
    end
    
    methods
        function self = UTest(fileName)
            if nargin > 0
                self.testclassName = self.filePre + fileName;
                self.testclassHndl = str2func(self.testclassName); 
            end
        end
        function self = test(self)
            runtests(self.testclassName); %%TODO: report code coverage               
        end
    end
    
    methods (Static, Access = protected)
        isEqual = equalClock(actual, expected)
        initsEmpty = basic_check()    
    end
end