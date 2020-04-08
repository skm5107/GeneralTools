classdef CSVHeader < handle
    properties (GetAccess = private)
        raw
    end
    
    properties (SetAccess = private)
        Props
        FormSpec        
    end
    
    properties (Dependent)
        delRows
    end
    
    properties (Access = private)
        isInSitu = true
        out
    end
    
    properties (Constant, Access = private)
        delChar = "#"
    end

    methods
        function self = CSVHeader(raw,isInSitu)
            if nargin > 0
                self.raw = raw;
            end
            if nargin > 1
                self.isInSitu = isInSitu;
            end
        end
        
        function self = run(self)
            self.out = self.raw;
            self.FormSpec = FormatSpec(self.out{1,:});
            self = self.setTblProp("VariableUnits", 3);
            self = self.setTblProp("VariableDescriptions", 4);
            self = self.setTblDesc(5);
            self.Props = self.out.Properties;
        end
        
        function delRows = get.delRows(self)
            if self.isInSitu
                delRows = 1:4;
            else
                delRows = [];
            end
        end
    end
    
    methods (Access = private)
        self = makeSpec(self, headerRow)
        self = setTblProp(self, propName, headerRow)
        self = setTblDesc(self, headerRow)
        
        function rawRow = getRawHead(self, headerRow)
            rawRow = string(self.out{headerRow, :});
            rawRow = strrep(rawRow, self.delChar, "");
        end
    end
end