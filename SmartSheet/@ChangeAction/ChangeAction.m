classdef ChangeAction
    properties (GetAccess = private)
        raw (1,1) string
    end
    
    properties (SetAccess = private)
        target
        move
    end
    
    properties (Access = private)
        lowed
        action
    end
    
    properties (Constant, Access = private)
        dropAfter = " ("
        allTargets = ["Activity Log", "Sheet", "Column", "Row", "Cell"]
        ignorePres = ["s ", " "]
    end
    
    methods
        function self = ChangeAction(raw)
            if nargin > 0
                self.raw = raw;
            end
        end
        
        function [self] = run(self)
            self.lowed = lower(self.raw);
            self.action = self.getAction();
            self.target = self.getTarget();
            self.move = self.getMove();
        end
        
        function [target, move] = runprops(self)
            self = self.run();
            target = self.target;
            move = self.move;
        end
    end
    
    methods (Access = private)
        function action = getAction(self)
            action = extractBefore(self.lowed, ChangeAction.dropAfter);
            if isempty(action)
                action = self.raw;
            end
        end
        function target = getTarget(self)
            allTargs = lower(ChangeAction.allTargets);
            id = Str.loop(self.action, allTargs, @contains);
            target = allTargs(id);
            target = categorical(target);
        end
        
        function move = getMove(self)
            remainder = erase(self.action, string(self.target));
            id = Str.loop(remainder, ChangeAction.ignorePres, @startsWith);
            move = Str.eraseStart(remainder, ChangeAction.ignorePres(id));
            move = categorical(move);
        end
    end
end