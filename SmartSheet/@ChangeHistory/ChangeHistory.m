classdef ChangeHistory
    properties
        completes
        log
    end
    
    properties (SetAccess = private)
        histories = ChangedTask.empty
    end
    
    methods
        function self = ChangeHistory(completes, log)
            if nargin > 0
                self.completes = completes;
            end
            if nargin > 1
                self.log = log;
            end
        end
        
        function self = run(self)
            for ic = 1:height(self.completes)
                self.histories(ic) = ChangedTask(self.completes(ic, :), self.log).run;
            end
        end
    end
end