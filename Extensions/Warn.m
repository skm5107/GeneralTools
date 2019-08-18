classdef Warn
    methods (Static)
        function warnIf(condition, warn, id)
            if nargin < 3
                id = "Custon:Blank";
            elseif ~contains(id, ":")
                id = "Custom:"+id;
            end
            
            if condition
                warning(id, warn);
            end
        end
        
        function warnIfNot(condition, warn, id)
            if nargin > 2
                Warn.warnIf(~condition, warn, id);
            else
                Warn.warnIf(~condition, warn);
            end
        end
    end
end