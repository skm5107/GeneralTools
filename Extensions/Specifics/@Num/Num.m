classdef Num
    methods (Static)
        [tf_all, tf_vect] = isnum(str)
        
        function [tf_all, tf_vect] = iseven(nums)
            tf_vect = mod(nums, 2) == 0;
            tf_all = all(tf_vect);
        end
    end
    
    methods (Static)        
        function values = nan2zero(values)
            values(isnan(values)) = 0;
        end
        
        summed = nansum(vals, varargin)
        
        function difference = nansubtract(minuend, subtrahend)
            difference = minuend - subtrahend;
            indsNaN = all(isnan([minuend, subtrahend]), 2);
            difference(indsNaN, :) = 0;
        end
    end
    
    methods (Static)
        [ints, decimals] = getDigits(number, precision_decimals)
    end
end