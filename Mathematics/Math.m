classdef Math
    methods (Static)
        function wrapped = wrap(val, shift, range)
            ind = val == range;
            range_shifted = circshift(range, -shift);
            wrapped = range_shifted(ind);
        end
        
        function summed = nansum(vect, varargin)
            vect(isnan(vect)) = [];
            summed = sum(vect, varargin{:});
        end
       
        function rng = range(vect)
            rng = max(vect) - min(vect);
        end
        
        function int_tf = isint(val)
            int_tf = rem(val, 1) == 0;
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