classdef ImportedHeader < AbstHeader
    properties
        Imported (1,1) ImportedRaw
    end
    
    properties (Dependent)
        cleaned

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

    methods
        function self = ImportedHeader(Imported)
            if nargin > 0
                self.Imported = Imported;
            end
        end
    end

    methods
        function cleaned = get.cleaned(self)
            cleaned = strrep(self.Imported.raw, ...
                self.Imported.Info.strip_char, "");
        end
        
        function varNames = get.varNames(self)
            ind = self.Imported.Info.headerRows == "VariableNames";
            varNames = self.cleaned(ind,:);
        end
        
        function ConvertVect = get.ConvertVect(self)
            ind = self.Imported.Info.headerRows == "VariableTypes";
            varVect = self.cleaned(ind,:);
            ConvertVect = FormatVector(varVect);
            
        end
        
        function varUnits = get.varUnits(self)
            ind = self.Imported.Info.headerRows == "VariableUnits";
            varUnits = self.cleaned(ind,:);
        end
        
        function varDescs = get.varDescs(self)
            ind = self.Imported.Info.headerRows == "VariableDescriptions";
            varDescs = self.cleaned(ind,:);
        end
        
        function tblDesc = get.tblDesc(self)
            ind = self.Imported.Info.headerRows == "Description";
            tblDesc = self.cleaned(ind,:);
            tblDesc = join(tblDesc,"");
        end
    end
    
    methods
        function isSaved = get.isSaved(self)
            isSaved = true([1 self.Imported.Info.nVars]);
        end
        
        function varMult = get.varMult(self)
            varMult = ones([1 self.Imported.Info.nVars]);
        end
        
        function notes = get.notes(self)
            notes = strings([1 self.Imported.Info.nVars]);
        end
        
        function nVars = get.nVars(self)
            nVars = self.Imported.Info.nVars;
        end
    end
end
