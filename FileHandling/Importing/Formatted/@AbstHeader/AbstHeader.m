classdef (Abstract) AbstHeader
    % Interface class providing all header information used by FormattedCsv.
    
    properties (Abstract, Dependent)
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
    
    methods
        function example = get.example(self)
            example = metaInfo_add(self, self.standinTable_make);
        end
        
        nested = metaInfo_add(self, rawTable)
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
                mult(~Val.isFull(mult)) = 1;
                if isnumeric(rawTable{:, ivar})
                    multed{:,ivar} = rawTable{:, ivar} .* mult;
                end
            end
        end
    end
end
