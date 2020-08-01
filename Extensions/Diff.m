classdef Diff
    methods (Static)
        function [tblHasDiffs, diffXY] = table(diffs)
            elemDiff = varfun(@(idiff) Log.diffVal_check(idiff), diffs);
            colDiff = varfun(@(col) all(col, 1), elemDiff);
            tblHasDiffs = all(colDiff{:,:});
            
            [diffX, diffY] = find(elemDiff{:,:});
            diffXY = [diffX, diffY];
        end
        
        function hasDiff = val(diffVal)
            if islogical(diffVal)
                hasDiff = ~diffVal;
            elseif isnumeric(diffVal)
                hasDiff = diffVal ~= 0;
            else
                assert(false, "Diff:Type", "Cannot check diff of datatype %s", class(diffVal));
            end
        end
    end
end