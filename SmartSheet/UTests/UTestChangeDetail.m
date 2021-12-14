classdef UTestChangeDetail < UTest
    properties (Constant, TestParameter)
        exps = loadExps()
    end
    
    properties (Constant, Access = private)
        omitfields = "input"
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
    exps{ind}.input = 'Row 4444: ""Row Number 4444""';
    exps{ind}.num = 4444;
    exps{ind}.name = "Row Number 4444";    
    
    ind = ind + 1;
    exps{ind}.input = 'Row 1: "Task Name" Start Week: 01/01/11 to: 02/02/22';
    exps{ind}.num = 1;
    exps{ind}.name = "Task Name";
    exps{ind}.old = ChangeDetail.const.parses.old;
    exps{ind}.old.start = datetime("01/01/11", 'InputFormat', "MM/dd/yy");
    exps{ind}.new = ChangeDetail.const.parses.new;
    exps{ind}.new.start = datetime("02/02/22", 'InputFormat', "MM/dd/yy");
    
    ind = ind + 1;
    exps{ind}.input = 'Row 651: "Design of Wire Harness Part C" State: Red to: Green Duration: 116d to: 118d';
    exps{ind}.num = 651;
    exps{ind}.name = "Design of Wire Harness Part C";
    exps{ind}.old = ChangeDetail.const.parses.old;
    exps{ind}.old.state = categorical("Red");
    exps{ind}.old.dur_bus = "116d";
    exps{ind}.new = ChangeDetail.const.parses.new;
    exps{ind}.new.state = categorical("Green");
    exps{ind}.new.dur_bus = "118d";
    
    ind = ind + 1;
    exps{ind}.input = 'Row 649: "Design of Wire Harness Part A" State: Red to: Green Duration: 113d to: 116d Start: 11/11/2021 to: 12/12/2022';
    exps{ind}.num = 649;
    exps{ind}.name = "Design of Wire Harness Part A";
    exps{ind}.old = ChangeDetail.const.parses.old;
    exps{ind}.old.state = categorical("Red");
    exps{ind}.old.dur_bus = "113d";
    exps{ind}.old.start = datetime("11/11/2021", 'InputFormat', "MM/dd/yy");
    exps{ind}.new = ChangeDetail.const.parses.new;
    exps{ind}.new.state = categorical("Green");
    exps{ind}.new.dur_bus = "116d";  
    exps{ind}.new.start = datetime("12/12/2022", 'InputFormat', "MM/dd/yy");
end

