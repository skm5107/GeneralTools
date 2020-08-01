classdef FlatTable
    properties (GetAccess = protected)
        nested table
    end
    
    properties (SetAccess = protected)
        flattened
        flatVects cell = cell.empty
        flatNames cell
    end
    
    properties (Access = private)
        varN = 1
    end
    
    %% Constructor & Runners
    methods
        function self = FlatTable(nested)
            if nargin > 0
                self.nested = nested;
            end
        end
        
        function [flattened, flatVects] = run(self)
            self = allSubtables_find(self);
            self = nestedcells_extract(self);
            flatVects = self.flatVects;
            
            self.flatNames = Tbl.vect2name(self.flatVects, Tbl.flatDivider);
            if ~iscell(self.flattened)
                self.flattened = num2cell(self.flattened);
            end
            self.flattened = cell2table(self.flattened, 'VariableNames', self.flatNames);
            try
                self.flattened = varfun(@(col) col{:}, self.flattened);
            end
            self.flattened.Properties.VariableNames = self.flatNames;
            flattened = self.flattened;
        end
    end
    
    %% Internal Functions
    methods (Access = private)
        function self = allSubtables_find(self)
            self.flattened = self.table2cellCols(self.nested);
            for icol = 1:width(self.nested)
                self = self.istable_check(self.nested, cell.empty, icol);
                self.flattened{:, icol} = self.cell_loop(self.flattened{:, icol});
            end
        end
        
        function self = nestedcells_extract(self)
            while size(self.flattened, 2) < length(self.flatVects)
                for icol = 1:size(self.flattened, 2)
                    self.flattened = self.extract_loop(self.flattened, icol);
                end
            end
            
        end
    end
    %% Variable Name Loops
    methods (Access = private)
        function [self, varVect] = istable_check(self, subtable, varVect, icol)
            varVect = [varVect, subtable.Properties.VariableNames(icol)]; %#ok<*AGROW>
            if istable(subtable{:, icol})
                [self, varVect] = self.varVect_build(subtable{:, icol}, varVect);
            else
                self.flatVects = [self.flatVects; {varVect}];
                varVect = varVect(1:end-1);
            end
        end
        
        function [self, varVect] = varVect_build(self, subtable, varVect)
            for icol = 1:width(subtable)
                [self, varVect] = self.istable_check(subtable, varVect, icol);
            end
        end
    end
    
    %% Table2Cell Loops
    methods (Access = private)
        function flattened = cell_loop(self, flattened)
            if istable(flattened)
                flattened = self.table2cellCols(flattened);
                for icol = 1:size(flattened, 2)
                    if istable(flattened{:, icol})
                        flattened{:, icol} = self.cell_loop(flattened{:, icol});
                    end
                end
            end
        end
        
        function flattened = extract_loop(~, flattened, icol)
            if iscell(flattened{:, icol})
                flattened = [flattened(:, 1:icol-1), flattened{:, icol}, flattened(:, icol+1:end)];
            end
        end
        
        function cellCols = table2cellCols(~, tbl)
            cells = table2cell(tbl);
            cellCols = cell([1, size(cells, 2)]);
            for icol = 1:size(cells, 2)
                cellCols{icol} = vertcat(cells{:, icol});
            end
        end
    end
end
