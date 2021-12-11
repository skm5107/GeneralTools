classdef Schedule
    properties (GetAccess = private)
        raw
    end
    
    properties (SetAccess = private)
        Tasks (1,:) Task
        checked
    end
    
    properties (Dependent, Hidden)
        tbl
    end
    
    properties (Constant, Access = private)
        finName = "<Finish Standin>"
        finDur = 0
    end
    
    methods
        function self = Schedule(raw)
            if nargin > 0
                self.raw = raw;
            end
        end
        
        function [Tasks, checked, self] = run(self)
            self = self.makeTasks();
            self = self.parentTasks();
            self = self.predTasks();
            
            [self.checked.fin, self.checked.fins] = self.check_finishes();
            
            Tasks = self.Tasks;
            checked = self.checked;
        end
    end
    
    methods
        [req, reqs] = checkReqd(self, id)
        mthly = monthlyCosts(self)
        
        function tbl = get.tbl(self)
            for itask = 1:length(self.Tasks)
                JTask = self.Tasks(itask);
                tbl(itask,:) = JTask.row; %#ok<AGROW>
            end
        end
    end
    
    methods (Access = private)
        self = makeTasks(self)
        self = parentTasks(self)
        self = predTasks(self)
        [fin, fins] = check_finishes(self)
    end
end