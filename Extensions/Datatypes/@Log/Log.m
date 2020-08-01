classdef Log
    methods (Static)
        uniqued = uniqueByRow(input)
        rows_tf = isequalnByRow(rowsA, rowsB)
        
        tf = anyequaln(value, anyOfvalues)
        tfs = contains(arr, includes)
        [matches, inds] = allany(optsList, rules)
        
        function tf = all(arr_tf)
            tf = all(arr_tf(:));
        end
        
        val = firstNotEmpty_select(varargin)
        [indsPass_ind, indsPass_tf] = indices_choose(acceptableInds, selectionsOfAcceptableSet)
        function inds = inds_btwn(vals, bounds)
            inds = vals >= min(bounds) & vals <= max(bounds);
        end
        
        logVect = num2log(numVect)
        catTbl = tf_tables(logTbl)
    end
end