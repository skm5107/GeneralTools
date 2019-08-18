classdef ConstRequestor
    % Directory  map of CSV files for only specified identifiers
    
    properties
        reqIds string
    end
    
    properties (SetAccess = private)
        map
    end
    
    properties %(Access = private)
        folderMap table
    end
    
    %% Constructor
    methods
        function self = ConstRequestor(reqIds, folderMap)
            if nargin > 0
                self.reqIds = reqIds;
            end
            if nargin > 1 && ~isempty(folderMap)
                self.folderMap = folderMap;
            end
        end

        function [map, self] = run(self)
            matchIds = cellfun(@(ids) startsWith(string(ids), self.reqIds), self.folderMap.ids, 'uni', 0);
            matchAllReqs = cellfun(@(matches) all(matches), matchIds);
            map = self.folderMap(matchAllReqs, :);
        end
    end
    
    methods
        function self = set.reqIds(self, reqIds)
            reqIds = lower(reqIds);
            self.reqIds = reshape(reqIds, [length(reqIds), 1]);
        end
    end
end