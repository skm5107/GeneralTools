classdef UTestChangeDetail < UTest
    properties (Constant, TestParameter)
        exps = loadExps()
    end
    
    properties (Constant, Access = private)
        omitfields = "input"
    end
    
    methods(TestClassSetup)
        function rerunSetup(~)
            clear ChangeDetail
        end
    end
    
    methods (Test, ParameterCombination ='sequential')
        function exps_test(tester, exps)
            act = ChangeDetail(exps.input).run;
            flds = string(fields(exps)');
            testflds = setxor(flds, UTestChangeDetail.omitfields);
            for jfield = testflds
                tester.verifyEqual(act.(jfield), exps.(jfield))
            end
        end
    end
end

function exps = loadExps()
    ind = 0;
    
    ind = ind + 1;
    exps{ind}.input = 'Row: "No Row Number"';
    exps{ind}.num = NaN;
    exps{ind}.name = "No Row Number";
    
    ind = ind + 1;
    exps{ind}.input = 'Row 1: "Row Number 1"';
    exps{ind}.num = 1;
    exps{ind}.name = "Row Number 1";
    
    ind = ind + 1;
    exps{ind}.input = 'Row 22: "Row Number 22"';
    exps{ind}.num = 22;
    exps{ind}.name = "Row Number 22";
    
    ind = ind + 1;
    exps{ind}.input = 'Row 333: "Row Number 333"';
    exps{ind}.num = 333;
    exps{ind}.name = "Row Number 333";
    
    ind = ind + 1;
    exps{ind}.input = 'Row 1: "Task Name" Start Week: 01/01/11 to: 02/02/22';
    exps{ind}.num = 1;
    exps{ind}.name = "Task Name";
    exps{ind}.old = ChangeDetail.const.parses.old;
    exps{ind}.old.start = "01/01/11";
    exps{ind}.new = ChangeDetail.const.parses.new;
    exps{ind}.new.start = "02/02/22";
    
    ind = ind + 1;
    exps{ind}.input = 'Row 990: ""Receive Flight Solar Panel"" Task Name: Receive Flight Solar Panel to: "Receive Flight Solar Panel" Start Week: 3/3/33 to: 4/4/44';
    exps{ind}.num = 990;
    exps{ind}.name = "Receive Flight Solar Panel";
    exps{ind}.old = ChangeDetail.const.parses.old;
    exps{ind}.old.name = "Receive Flight Solar Panel";
    exps{ind}.old.start = "3/3/33";
    exps{ind}.new = ChangeDetail.const.parses.new;
    exps{ind}.new.name = """Receive Flight Solar Panel""";
    exps{ind}.new.start = "4/4/44";    
end
