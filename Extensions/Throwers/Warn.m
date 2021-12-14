classdef Warn
    methods (Static)
        function isWarn = warnIf(condition, varargin)            
            if nargin < 2 || ~Val.isFull(varargin)
                varargin = " ";
            end
            
            if condition
                warning(varargin{:})
                isWarn = true;
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