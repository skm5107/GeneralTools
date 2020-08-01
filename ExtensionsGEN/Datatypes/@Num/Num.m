classdef Num
    methods (Static)
        [tf_all, tf_vect] = isnum(str)
        [tf_all, tf_vect] = iseven(nums)
        
        nan1 = keepFirstNan(allNans)
        summed = nansum(vals, varargin)
        difference = nansubtract(minuend, subtrahend)
        noNans = delNans(withNans)
        values = nan2zero(values)
        
        last = lastGreater(array, val)
        [dim, val] = getDim(input, minORmax)
        buffered = buffer(bounds, buff)
        
        rolling = stepped2cumsum(stepped, step_inc, sum_dist)
        
        [ints, decimals] = getDigits(number, precision_decimals)
    end
end