classdef Math
    methods (Static)
        function buffered = buffer(bounds, buff)
            buffered(1) = min(bounds) - buff;
            buffered(2) = max(bounds) + buff;
        end
        
        function last = lastGreater(array, val)
            vect = max(array, [], Num.getDim(array, "min"));
            last = find(vect >= val, 1, 'last');
        end
        
        function rolling = stepped2cumsum(stepped, step_inc, sum_dist)
            value = stepped / step_inc;
            value(isnan(value)) = 0;
            rolling = cumsum(value, sum_dist / step_inc);
        end
        
        function [quot, modulo] = modDiv(dividend, divisor)
            modulo = mod(dividend, divisor);
            quot = floor(dividend/divisor);
        end
    end
end