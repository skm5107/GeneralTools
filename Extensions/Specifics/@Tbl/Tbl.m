classdef Tbl
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
        tbl = cells2nested(cells)
    end
    
    %% Metadata
    methods (Static)
        function target = meta_copy(orig, target)
            for iprop = fields(orig.Properties)'
                target.Properties.(iprop{:}) = orig.Properties.(iprop{:});
            end
        end
        
        function orig = defaultVars(orig)
            orig.Properties.VariableNames = Tbl.defvars_make(1 : width(orig));
        end
        function varN = defvars_make(nums)
            varN = cellstr(repmat(Tbl.defaultVar, [1 length(nums)]) + string(nums));
        end
    end
    
    %% Variable Naming
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
    
    %% Rows & Columns
    methods (Static)
        function buffered = buffer(orig, row_qty)
            misses = repmat(missing, [row_qty, width(orig)]);
            buffered = [orig; array2table(misses, 'VariableNames', orig.Properties.VariableNames)];
        end
        
        function new = insertCol(old, name, values, position)
            old.(name)(:) = values;
            new = movevars(old, name, 'Before', position);
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
    
    %% Elements
    methods (Static)
        function new = cellfun(fcn_hndl, orig, varargin)
            hgt = num2cell(1:size(orig, 1));
            new = cellfun(@(irow) fcn_hndl(orig(irow, :)), hgt, varargin{:});
        end
    end
    
    methods (Static)
        function sub = makeSub(orig, wantVars)
            wantInds = Tbl.isVar(orig, wantVars);
            sub = orig(:, wantInds);
            sub.Properties.Description = orig.Properties.Description;
            sub = movevars(sub, cellstr(wantVars), 'Before', 1);
        end
    end
    
    %% Empty Tables
    methods (Static)
        function empty = emptyCols(hgt, varNames, varTypes)
            if nargin < 3
                varTypes = {'string'};
            else
                varTypes = cellstr(varTypes);
            end
            
            wid = length(varTypes);
            if nargin < 2
                varNames = Tbl.defvars_make(wid);
            else
                varNames = cellstr(varNames);
            end
            
            wid = max(length(varTypes), length(varNames));
            if length(varTypes) == wid && length(varNames) == 1
                    varNames = repmat(varNames, [1, wid]);
            elseif length(varNames) == wid && length(varTypes) == 1
                varTypes = repmat(varTypes, [1, wid]);
            end
            
            empty = table('Size', [hgt, wid], 'VariableNames', varNames, 'VariableTypes', varTypes);
        end
        
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
    end
end