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
        [reqVals, reqRows, reqRaw] = lookup(key, checkVal, checkVars, reqVars)
    end
end