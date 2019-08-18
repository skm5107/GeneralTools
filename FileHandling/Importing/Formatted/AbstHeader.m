classdef (Abstract) AbstHeader
    % Interface class providing all header information used by FormattedCsv.
    
    properties (Abstract, Dependent, SetAccess = protected)
        varNames
        varUnits
        varDescs
        
        ConvertVect
        varMult
        isSaved
        
        tblDesc
        notes
        
        nVars
        varNcol
    end
    
    properties (SetAccess = protected)
        example
    end
    
    %% Getters
    methods
        function example = get.example(self)
            example = metaInfo_add(self, self.standinTable_make);
        end
        function nested = metaInfo_add(self, rawTable)
            assert(isequaln(width(rawTable), self.nVars), ...
                "Table Header Formatter: width of table for metaInfo_add(self, table) must equal self.nVars.")
            metad = self.variables_mult(rawTable);
            metad.Properties.VariableUnits = cellstr(self.varUnits);
            metad.Properties.VariableDescriptions = cellstr(self.varDescs);
            metad.Properties.Description = char(self.tblDesc);
            metad.Properties.VariableNames = cellstr(self.varNames);
            nested = metad;
            
%             nested = table(); %TODO: is alphabetizing the columns?
%             for icol = 1:width(metad)
%                 col = Tbl.nested_name(self.varNames{icol}, metad{:, icol});
%                 nested = Tbl.nested_horzcat(nested, col);
%             end
        end
    end
    
    methods (Access = private)
        function blank = standinTable_make(self)
            blank = table('Size', [1 self.nVars], ...
                'VariableTypes', cellstr(self.ConvertVect.ref.varType'));
            blank(1,:) = self.ConvertVect.ref.missVal';
        end
        
        function multed = variables_mult(self, rawTable)
            multed = rawTable;
            for ivar = 1:width(rawTable)
                mult = self.varMult(ivar);
                mult(~Fcn.isFull(mult)) = 1;
                if isnumeric(rawTable{:, ivar})
                    multed{:,ivar} = rawTable{:, ivar} .* mult;
                end
            end
        end
    end
end
