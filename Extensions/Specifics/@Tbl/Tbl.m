classdef Tbl    
    properties (Constant)
        defVar = "Var"
    end
    
    methods (Static)
        function new = substituteCol(orig, addition, colInd)
            new = [orig(:, 1:colInd-1), addition, orig(:, colInd+1:end)];
        end
        
        function new = insertCol(old, name, values, position)
            old.(name)(:) = values;
            new = movevars(old, name, 'Before', position);
        end        
        
        function buffered = buffer(orig, row_qty)
            misses = repmat(missing, [row_qty, width(orig)]);
            buffered = [orig; array2table(misses, 'VariableNames', orig.Properties.VariableNames)];
        end      
        
        function new = rowfun(fcn_hndl, orig, varargin)
            hgt = num2cell(1:size(orig, 1));
            new = cellfun(@(irow) fcn_hndl(orig(irow, :)), hgt, varargin{:});
        end        
        
        tbl = unique(tbl, keepFirst)
        [tf, val] = isVar(tbl, varName)
        trans = transpose(raw)
        trans = invertMeta(raw)
        empty = emptyCols(hgt, varNames, varTypes)
        orig = defaultVars(orig)        
    end  
end