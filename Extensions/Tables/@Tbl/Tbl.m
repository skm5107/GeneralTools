classdef Tbl
    % Methods to extend the MATLAB table class
    
    properties (Constant)
        nestDivider = "."
        flatDivider = "_"
        unitsDivider = "_"
        defaultVar = "Var";
    end
    
    methods (Static)
        [nest, nestNames] = nested_name(varName, val)
        flatNames = names_flatten(orig);
        joint = nested_horzcat(old, new)
        [val, inds_tf] = woUnits(tbl, varName)
        tbl = unique(tbl, keepFirst)
        [tf, val] = isVar(tbl, varName)
        sub = makeSub(orig, wantVars)
        trans = transpose(raw)
        varNames = vect2name(varVect, div)
        varVect = name2vect(varNames, div)
        empty = emptyCols(hgt, varNames, varTypes)
        trans = invertMeta(raw)
        celled = meta2cell(orig)
        celled = cell2meta(orig)        
        
        [reqTbl, reqVal] = lookup(tbl, matchVal, matchCol, reqCol)
        
        function buffered = buffer(orig, row_qty)
            misses = repmat(missing, [row_qty, width(orig)]);
            buffered = [orig; array2table(misses, 'VariableNames', orig.Properties.VariableNames)];
        end      
        
        function new = rowfun(fcn_hndl, orig, varargin)
            hgt = num2cell(1:size(orig, 1));
            new = cellfun(@(irow) fcn_hndl(orig(irow, :)), hgt, varargin{:});
        end        
        
        function new = insertCol(old, name, values, position)
            old.(name)(:) = values;
            new = movevars(old, name, 'Before', position);
        end          

        function new = substituteCol(orig, addition, colInd)
            new = [orig(:, 1:colInd-1), addition, orig(:, colInd+1:end)];
        end
        
        function orig = defaultVars(orig)
            orig.Properties.VariableNames = Tbl.defvars_make(1 : width(orig));
        end
        
        function varN = defvars_make(nums)
            varN = cellstr(repmat(Tbl.defaultVar, [1 length(nums)]) + string(nums));
        end
        
        function emptied = flat_empty(orig)
            emptied = Tbl.empty_create(orig, "missVal");
        end
        
        function emptied = flat_emptyDiff(orig)
            emptied = Tbl.empty_create(orig, "diffVal");
        end
    end
    
    methods (Static, Access = private)
        emptied = empty_create(orig, valType)
    end
end