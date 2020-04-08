classdef Log
    methods (Static)
        uniqued = uniqueByRow(input)
        rows_tf = isequalnByRow(rowsA, rowsB)
        tf = anyequaln(value, anyOfvalues)
        tfs = contains(arr, includes)
    end
    
    methods (Static)        
        val = firstNotEmpty_select(varargin)
        [indsPass_ind, indsPass_tf] = indices_choose(acceptableInds, selectionsOfAcceptableSet)
        
        function inds = inds_btwn(vals, bounds)
            inds = vals >= min(bounds) & vals <= max(bounds);
        end
    end
    
    methods (Static)
        logVect = num2log(numVect)
        catTbl = tf_tables(logTbl)
    end
end