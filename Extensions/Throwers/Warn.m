classdef Warn
    methods (Static)
        function warnIf(condition, id, warn)
            if nargin < 2 || ~Val.isFull(id)
                id = "Custon:Blank";
            elseif ~contains(id, ":")
                id = "Custom:"+id;
            end
            
            if nargin < 3 || ~Val.isFull(warn)
                warn = "";
            end
            
            if condition
                warning(id, warn);
            end
        end
        
        function warnIfNot(condition, id, warn)
            if nargin > 2
                Warn.warnIf(~condition, warn, id);
            else
                Warn.warnIf(~condition, warn);
            end
        end
    end
    
    properties (Constant)
        mExt = [".m", ".mlx"];
    end
end