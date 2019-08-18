classdef Log
    % Static methods for logicals
    
    %% Extended Functions
    methods (Static)
        function tf = all(arr_tf)
            tf = all(arr_tf(:));
        end
        
        function uniqued = uniqueByRow(input)
            uniqued = cell(size(input, 1), 1);
            for irow = 1:size(input,1)
                crow = input(irow,:);
                crow = Num.keepFirstNan(crow);
                uniqued{irow, 1} = unique(crow);
            end
        end        
        
        function rows_tf = isequalnByRow(rowsA, rowsB)
            rows_tf = false([size(rowsA, 1), 1]);
            if size(rowsA, 1) ~= size(rowsB, 1)
                return
            end
            for irow = 1:size(rowsA, 1)
                rows_tf(irow) = isequaln(rowsA(irow,:), rowsB(irow,:));
            end
        end
    end
    
    %% Converters
    methods (Static)
        function logVect = num2log(numVect)
            vect = nan(size(numVect));
            for ind = 1:length(numVect)
                vect(ind) = Frmt.log(numVect(ind));
            end
            if ~any(isnan(vect))
                logVect = logical(vect);
            else
                logVect = vect;
            end 
        end
        
        function catTbl = tf_tables(logTbl)
            catTbl = logTbl;
            for jvar = catTbl.Properties.VariableNames
                if islogical(logTbl.(jvar{:}))
                    catTbl.(jvar{:}) = categorical(logTbl.(jvar{:}));
                end
            end
        end
    end
    
    %% Testers
    methods (Static)        
        function [indsPass_ind, indsPass_tf] = indices_choose(acceptableInds, selectionsOfAcceptableSet)         
            indsAll = find(acceptableInds);
            indsPass_ind = indsAll(logical(selectionsOfAcceptableSet));
            
            indsPass_tf = false(size(acceptableInds));
            indsPass_tf(indsPass_ind) = true;
        end
        
        function inds = inds_btwn(vals, bounds)
            inds = vals >= min(bounds) & vals <= max(bounds);
        end
    end
    
    %% Difference Checking
    methods (Static)
        function [tblHasDiffs, diffXY] = diffTable_check(diffs)
            elemDiff = varfun(@(idiff) Log.diffVal_check(idiff), diffs);
            colDiff = varfun(@(col) all(col, 1), elemDiff);
            tblHasDiffs = all(colDiff{:,:});
            
            [diffX, diffY] = find(elemDiff{:,:});
            diffXY = [diffX, diffY];
        end
        
        function hasDiff = diffVal_check(diffVal)
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