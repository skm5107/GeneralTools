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