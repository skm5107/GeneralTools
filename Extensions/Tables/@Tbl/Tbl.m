classdef Tbl
    % Methods to extend the MATLAB table class
    
    properties (Constant)
        nestDivider = "."
        flatDivider = "_"
        unitsDivider = "_"
        defaultVar = "Var";
    end
    
    methods (Static)
        tbl = asgnMatchVars(src, tbl)
        
        [nest, nestNames] = nested_name(varName, val)
        flatNames = names_flatten(orig);
        joint = nested_horzcat(old, new)
        [val, inds_tf] = woUnits(tbl, varName)
        tbl = unique(tbl, keepFirst)
        [reqTbl, reqVal] = lookup(tbl, matchVal, matchCol, reqCol)
    end
    
    methods (Static)
        function orig = defaultVars(orig)
            orig.Properties.VariableNames = Tbl.defvars_make(1 : width(orig));
        end
        function varN = defvars_make(nums)
            varN = cellstr(repmat(Tbl.defaultVar, [1 length(nums)]) + string(nums));
        end
    end
    
    methods (Static)
        function sub = makeSub(orig, wantVars)
            wantInds = Tbl.isVar(orig, wantVars);
            sub = orig(:, wantInds);
            sub.Properties.Description = orig.Properties.Description;
            sub = movevars(sub, cellstr(wantVars), 'Before', 1);
        end
        
        function trans = transpose(raw)
            newHeight = max(cellfun(@(elem) size(elem, 2), table2cell(raw)));
            trans = repmat(raw, [newHeight 1]);
            for jprop = raw.Properties.VariableNames
                newVal = raw.(jprop{:})';
                trans.(jprop{:}) = [newVal; repmat(newVal, [newHeight - size(newVal,1), 1])];
            end
        end
    end
    
    methods (Static)
        function varNames = vect2name(varVect, div)
            varNames = cell([1, length(varVect)]);
            for ivar = 1:length(varVect)
                varNames(ivar) = join(varVect{ivar}, div);
            end
        end
        function varVect = name2vect(varNames, div)
            varVect = cell([length(varNames), 1]);
            for ivar = 1:length(varNames)
                varVect{ivar} = strsplit(varNames{ivar}, div);
            end
        end
    end
    
    methods (Static)
        tbl = copyEmpty(src)
        function emptied = flat_empty(orig)
            emptied = Tbl.empty_create(orig, "missVal");
        end
        function emptied = flat_emptyDiff(orig)
            emptied = Tbl.empty_create(orig, "diffVal");
        end
    end
    methods (Static, Access = private)
        function emptied = empty_create(orig, valType)
            emptied = orig;
            for icol = 1:width(orig)
                typeRow = FormatKey.classRow_find(orig{:, icol});
                colName = emptied(:, icol).Properties.VariableNames;
                
                fillerVal = typeRow.(valType{:});
                fillerSz = size(emptied.(colName{:}));
                emptied.(colName{:}) = repmat(fillerVal{:}, fillerSz);
            end
        end
    end
    
    methods (Static)
        function [tf, val] = isVar(tbl, varName)
            tf = any(string(tbl.Properties.VariableNames) == string(varName)', 1);
            if any(tf)
                val = tbl{:,tf};
            else
                val = NaN;
            end
        end
        
        function varNames = varlist(structORtbl)
            if ismember("table", Cls.allclasses(structORtbl))
                varNames = structORtbl.Properties.VariableNames;
            else
                varNames = fields(structORtbl);
            end
        end
        
        function buffered = buffer(orig, row_qty)
            misses = repmat(missing, [row_qty, width(orig)]);
            buffered = [orig; array2table(misses, 'VariableNames', orig.Properties.VariableNames)];
        end
        
        function new = insertCol(old, name, values, position)
            old.(name)(:) = values;
            new = movevars(old, name, 'Before', position);
        end
        
        function new = substituteCol(orig, addition, colInd)
            new = [orig(:, 1:colInd-1), addition, orig(:, colInd+1:end)];
        end
        
        function new = rowfun(fcn_hndl, orig, varargin)
            hgt = num2cell(1:size(orig, 1));
            new = cellfun(@(irow) fcn_hndl(orig(irow, :)), hgt, varargin{:});
        end
        
        empty = emptyCols(hgt, varNames, varTypes)
        trans = invertMeta(raw)
        celled = meta2cell(orig)
        celled = cell2meta(orig)
        
    end
end