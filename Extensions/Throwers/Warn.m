classdef Warn
    methods (Static)
        function isWarn = warnIf(condition, id, warn)
            if nargin < 2 || ~Val.isFull(id)
                id = "Custon:Blank";
            elseif ~contains(id, ":")
                id = "Custom:"+id;
            end
            
            if nargin < 3 || ~Val.isFull(warn)
                warn = "";
            end
            
            if condition
                isWarn = true;
                warning(id, warn);
            else
                isWarn = false;
            end
        end
        
        function isWarn = warnIfNot(condition, id, warn)
            if nargin > 2
               isWarn = Warn.warnIf(~condition, warn, id);
            else
                isWarn = Warn.warnIf(~condition, warn);
            end
        end
    end
    
    properties (Constant)
        mExt = [".m", ".mlx"];
    end
end