classdef (Abstract) Key < handle
    % Abstract naming interface for reference key classes that use CSV keys
    %%TODO: refactor/delete (move to Tbl)
    
    %% Load Reference Key
    properties (Abstract, Constant, Access = protected)
        keyPath
    end
    
    properties (Abstract, Constant)
        key
    end
    
    methods (Abstract, Static, Access = protected)
        key = key_format
    end
    
    %% Load Multiple CSVs into a single Key
    methods (Static)
        function key = multiload(dirMap, Header)
            key = table();
            for ifile = 1:height(dirMap.map)
                CurrentPath = FullPath(fullfile(dirMap.path, Fldr.dirfullpath(dirMap.map(ifile,:)))).run;
                if nargin < 2
                    currentKey = AutoImported(CurrentPath).run;
                else
                    currentKey = AutoImportKeyed(Header, CurrentPath).run;                    
                end
                
                key = [key; currentKey];
            end
            
            key = unique(key, 'rows');
        end
    end    
    
    %% Lookup Methods
    methods (Static)
        function [reqVals, reqRows, reqRaw] = lookup(key, checkVal, checkVars, reqVars)
            checkCols = Key.checkCols_get(key.Properties.VariableNames, checkVars);
            if ~any(checkCols)
                reqVals = table.empty(0, length(reqVars));
                return
            end
            checkKey = Key.cell_convert(key{:, checkCols});
            isInRow = cellfun(@(elem) Key.match_check(elem, checkVal), checkKey);
            reqRows = any(isInRow, 2);
            
            if nargin < 4 || isempty(reqVars)
                reqVals = key(reqRows, :);
            else
                reqCols = Key.checkCols_get(key.Properties.VariableNames, reqVars);
                reqVals = key(reqRows, reqCols);                
            end
            
            if nargout > 2
                reqRaw = reqVals{:,:};
            end
        end
    end
    
    methods (Static, Access = private)    
        function isMatch = match_check(elem, checkVal)
            try
                isMatch = any(elem == checkVal);
                if isMatch
                    return
                end
                
                %special algorithm for matching missing values
                specialMatch = ismissing(elem) && ismissing(checkVal) && ...
                               string(class(elem)) == string(class(checkVal));
                isMatch = isMatch || specialMatch;
            
            catch
                isMatch = any(isequaln(elem, checkVal));
            end
        end
        
        function checkCols = checkCols_get(varNames, wantVars)
            wantVars = string(wantVars);
            wantVars = reshape(wantVars, [length(wantVars), 1]);
            checkCols = any(varNames == wantVars, 1);
            if ~any(checkCols)
                warning("Requested variable does not exist in table.")
            end
        end
        
        function out = cell_convert(input)
            switch string(class(input))
                case "double"
                    out = num2cell(input);
                case "string"
                    out = cellstr(input);
                otherwise
                    out = input;
            end
        end
    end  
end