classdef FormatKey < Key
    % Reference key for FormatVector datatype codes
    
    %% Load Reference Key
    properties (Constant, Access = protected)
        currentLoc = fileparts(mfilename('fullpath'));
        csvKeyName = "format_key.csv";
        keyPath = fullfile(FormatKey.currentLoc, FormatKey.csvKeyName);
    end

    properties (Constant)
        key = FormatKey.key_format;
    end

    methods (Static, Access = protected)
        function key = key_format(~)
            key = AutoImported(FormatKey.keyPath).run;
            key.fcnHndl = cellfun(@(hndl) str2func(hndl), key.fcnHndl, 'uni', 0);
            key.diffHndl = cellfun(@(hndl) str2func(hndl), key.diffHndl, 'uni', 0);
            key.checkHndl = cellfun(@(hndl) str2func(hndl), key.checkHndl, 'uni', 0);
            
            key.missVal = cellfun(@(hndl) hndl(missing), key.fcnHndl, 'uni', 0);
            key.diffVal = cellfun(@(hndl) hndl(missing), key.diffHndl, 'uni', 0);
            
            key.varType = string(key.varType);
            key.importID = string(key.importID);
            key = movevars(key, {'finalID', 'typeID', 'importID', 'missVal', 'diffVal', 'varType', 'fcnHndl', 'checkHndl'}, 'Before', 1);
        end
    end    
    
    %% External Methods
    methods (Static)
        function row = classRow_find(val)
            ind = cellfun(@(checker) checker(val(:,1)), FormatKey.key.checkHndl);
            row = FormatKey.key(ind,:);
        end
    end
end