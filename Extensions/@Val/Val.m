classdef Val
    methods (Static)
        tf = isFull(val)
        isEqual = isEqual(a,b)
    end
    
    methods (Static)
        function vals = fillempty(vals, fill)
            vals(isempty(vals)) = fill;
        end
        
        orig = delmissing(orig)
        converted = castMissing(value)
        prop = delExtraMissing(prop)
        uniqued = nanunique(orig, firstORlast)
        varargout = empty_override(current, defaults)
    end
end