classdef ComparedTable
    properties (GetAccess = protected)
        newTable table
        oldTable table
    end
    
    properties (SetAccess = private)
        diffTable
        isMatch
        nonMatches
    end
    
    properties (Access = private)
        newFlat table
        oldFlat table
        nestedNames cell
    end
    
    %% Constructor & Runner
    methods
        function self = ComparedTable(newTable, oldTable)
            if nargin > 0
                self.newTable = newTable;
            end
            if nargin > 1
                self.oldTable = oldTable;
            end
        end
        
        function self = run(self)
            [self.newFlat, self.oldFlat, self.nestedNames] = self.tables_flatten(self.newTable, self.oldTable);
            self.diffTable = Tbl.flat_emptyDiff(self.newFlat);
            for icol = 1:width(self.newFlat)
                self.diffTable{:, icol} = self.col_diff(self.newFlat(:, icol), self.oldFlat(:, icol));
            end
            [self.isMatch, self.nonMatches] = self.diffTable_match(self.diffTable);
        end
    end
    
    %% Internal Methods
    methods (Access = private)
        function diff = col_diff(~, new, old)
            if isnumeric(new{:,:})
                diff = Num.nansubtract(new{:,:}, old{:,:});
            else
                diff = Log.isequalnByRow(new, old);
            end
        end
        
        function [isMatch, nonMatches] = diffTable_match(self, diffTable)
            [hasDiff, diffRC] = Diff.table(diffTable);
            nestNames = strrep(diffTable.Properties.VariableNames, Tbl.flatDivider, Tbl.nestDivider);
            
            nonMatches = table;            
            for idiff = 1:size(diffRC, 1)
                nonMatches(idiff, :) = nonMatch_log(self, nestNames, diffRC(idiff,:));
            end
            isMatch = ~hasDiff;
            
            if ~isempty(nonMatches)
                nonMatches.newPath(:) = string(self.newTable.Properties.Description);
                nonMatches.oldPath(:) = string(self.newTable.Properties.Description);
            end
        end
        
        function nonMatch = nonMatch_log(self, nestNames, diffRC)
            nonMatch = table;
            nonMatch.nestName = nestNames(diffRC(2));
            nonMatch.rowInd = diffRC(1);
            nonMatch.newVal = self.newFlat{diffRC(1),diffRC(2)};
            nonMatch.oldVal = self.oldFlat{diffRC(1), diffRC(2)};
            warning("Compare:Diff", "Changed Value: %s at %d was [%s], now [%s]", ...
                    nonMatch.nestName, nonMatch.rowInd, Str.type2str(nonMatch.newVal), Str.type2str(nonMatch.oldVal))
        end
    end
    
    methods (Static, Access = private)
        function [newFlat, oldFlat, varNames] = tables_flatten(newTable, oldTable)
            [newFlat, newNames] = FlatTable(newTable).run;
            [oldFlat, oldNames] = FlatTable(oldTable).run;
            assert(isequaln(newNames, oldNames), "New and old variable names are not identical");
            varNames = newNames;
        end
    end    
end