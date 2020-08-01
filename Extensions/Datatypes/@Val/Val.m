classdef Val
    methods (Static)
        tf = isFull(val)
        isEqual = isEqual(a,b)
    end
    
    methods (Static)
        function vals = fillempty(vals, fill)
            vals(isempty(vals)) = fill;
        end
        
        function orig = delmissing(orig)
            notFull = ~cellfun(@Val.isFull, num2cell(orig));
            orig(notFull) = [];
        end
        
        function converted = castMissing(value)
            if isequal(value, "missing") || isequal(value, "undefined")
                converted = Obj.cast(missing, class(value));
            else
                converted = value;
            end
        end
        
        function prop = delExtraMissing(prop)
            prop = Val.delmissing(prop);
            if isempty(prop)
                prop = Cls.cast(missing, class(prop));
            end
        end
    end
    
    methods (Static)
        function uniqued = nanunique(orig, firstORlast)
            miss_inds = find(ismissing(orig));
            uniqued = orig;
            if nargin < 2 || firstORlast == "first"
                uniqued(miss_inds(2:end)) = [];
            elseif firstORlast == "last"
                uniqued(miss_inds(2:end)) = [];
            else
                error("Arg:Unknown", 'nanunique(~, arg2) must be "first" or "last" (defaults to keeping first NaN)');
            end
        end
        
        function varargout = empty_override(current, defaults)
            overridden = current;
            for iarg = 1:length(current)
                if isempty(current{iarg})
                    overridden{iarg} = defaults{iarg};
                end
            end
            [varargout{1:nargout}] = overridden{:};
        end
    end
end