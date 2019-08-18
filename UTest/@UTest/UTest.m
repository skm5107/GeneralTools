classdef UTest < matlab.unittest.TestCase
    % Interface for toolbox's UnitTesting
    
    %% Test Runner
    properties (Access = private)
        className = string.empty;
    end
    properties (Constant, Access = protected)
        filePre = "UTest";
        fileExt = ".m";
        topDir = "UTest";
    end
    
    methods
        function self = UTest(fileName)
            if nargin > 0
                self.className = self.filePre + fileName;
                runtests(self.className) %%TODO: code coverage
            end
        end
    end
    
    %% Special Verifies
    methods (Static, Access = protected)
        function tf = equalClock(act, exp)
            if ismember(Cls.allclasses(act), "datetime") && ismember(Cls.allclasses(exp), "string")
                tf = all(isequaln(string(act), exp));
            else
                tf = all(isequaln(act, exp));
            end
        end
    end
    
    %% Standard Class Tests
    methods (Static, Access = protected)
        function [initsEmpty, checksTypes] = checkClass()
            mfile = erase(Fcn.getCallingFile(2), [UTest.filePre, UTest.fileExt]);
            classHndl = str2func(mfile);
            
            initsEmpty = UTest.verifyInitsEmpty(classHndl);
            checksTypes = UTest.verifyConstructorErrs(classHndl);
        end
    end
    
    methods (Static, Access = private)
        initsEmpty = verifyInitsEmpty(classHndl);
        checksTypes = verifyConstructorErrs(classHndl);
    end
    
    properties (Constant, Access = protected)
        emptyVal = ".empty";
        builtinClasses = ["double", "single", ...
                "int8", "int16", "int32", "int64", ...
                "uint8", "uint16", "uint32", "uint64", ...
                "char", "string", ...
                "logical", "function_handle", ...
                "table", "struct", "cell"];
    end
    
    %% Standard Test Inputs
    properties (Constant, Hidden) %%TODO: not being used, move
        infinites = [ {-inf}; {NaN}; {inf} ];
        finites = [ {-1}; {0}; {1}; {0.0001}; {-0.001}; {1000}; {100} ];
        numempties = [ {double.empty}; {double.empty(0, 1)}; {double.empty(0, 7)};
            {double.empty(1, 0)}; {double.empty(16, 0)} ]
        
        allnums = [ UTest.infinites; UTest.finites; UTest.numempties]
        
        strs = [ {"dc"}; {'ab'}; {";"}; {"/"}; {'c'}];
        strempties = [{""}; {''}; {string.empty};
            {string.empty(0, 1)}; {string.empty(0, 4)};
            {string.empty(1, 0)}; {string.empty(11, 0)}];
        
        nonnums = [UTest.strs; UTest.strempties];
        
        allstnds = [ UTest.allnums; ...
            UTest.nonnums ]
    end
    
    %% Standard Setup/Teardown
    properties (Constant, Access = private) %%TODO: plugin?
        wantLoc = "PCAMS_Analysis";
    end
    
    methods (TestClassSetup)
        function setLocation(~)
            Fldr.moveUpLocation(UTest.wantLoc);
        end
    end
end