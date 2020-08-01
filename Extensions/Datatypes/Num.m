classdef Num %% Move much of this to Math
    methods (Static)
        function nan1 = keepFirstNan(allNans)
            nanInds = find(isnan(allNans));
            nan1 = allNans;
            nan1(nanInds(2:end)) = [];
        end 
        
        function noNans = delNans(withNans)
            noNans = withNans;
            noNans(isnan(noNans)) = [];
        end
        
        function values = nan2zero(values)
            values(isnan(values)) = 0;
        end
        
        function difference = nansubtract(minuend, subtrahend)
            difference = minuend - subtrahend;
            indsNaN = all(isnan([minuend, subtrahend]), 2);
            difference(indsNaN, :) = 0;
        end
        
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
        
        function [dim, val] = getDim(input, minORmax)
            sz = size(input);
            if minORmax == "min"
                [val, dim] = min(sz);
            elseif minORmax == "max"
                [val, dim] = max(sz);
            else
                assert(false, "Select min or max dimension")
            end
        end
    end
end