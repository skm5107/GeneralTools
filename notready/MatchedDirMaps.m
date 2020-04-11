classdef MatchedDirMaps
    % Find rows in one dirMap that a provided functional handle says match the rows in another
    
    properties (GetAccess = protected)
        newMap table
        oldMap table
        isMatchHndl function_handle
    end
    
    properties (SetAccess = private)
        matches
    end
    
    %% Constructor & Runner
    methods
        function self = MatchedDirMaps(newMap, oldMap, isMatchHndl)
            if nargin > 0
                self.newMap = newMap;
            end
            if nargin > 1
                self.oldMap = oldMap;
            end
            if nargin > 2
                self.isMatchHndl = isMatchHndl;
            end
        end
        
        function matches = run(self)
            self.matches = self.matches_find(self.newMap, self.oldMap);
            matches = self.matches;
        end
    end
    
    %% Matchers
    methods (Access = private)
        function matches = matches_find(self, newMap, oldMap)
            for inew = 1:height(newMap)
                matches(inew, :) = self.new2old_match(newMap(inew, :), oldMap); %#ok<AGROW>
            end
            matches = self.nomatch_handle(matches);
        end
        
        function match = new2old_match(self, newRow, oldMap)
            match = table;
            match.new = Fldr.dirfullpath(newRow);
            match.old = missing;
            match.name = missing;
            
            for iold = 1:height(oldMap)
                [tryOld, tryName, isMatch] = self.isMatchHndl(newRow, oldMap(iold, :));
                if all(isMatch)
                    assert(ismissing(match.old), "More than 1 match for new %s:", match.new);
                    match.old = tryOld;
                    match.name = tryName;
                end
            end            
        end
        
        function matches = nomatch_handle(~, matches)
            missRows = ismissing(matches.old);
            missNames = cellfun(@(row) Fldr.fileext(row), matches.new(missRows, :));
            Warn.warnIf(any(missRows), sprintf("No old version matches for: %s", Prnt.vectprintf(missNames, ", ")));
            matches(missRows, :) = [];
        end
    end
end