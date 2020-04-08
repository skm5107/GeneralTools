classdef HeaderInfo < handle
    properties (GetAccess = private)
        header
    end
    
    properties (SetAccess = private)
        Props
        FormSpec        
    end
    
    properties (Dependent)
        delRows
    end
    
    properties (Access = private)
        iswData = true
    end
    
    properties (Constant, Access = private)
        delChar = "#"
        formatRow = 1
        unitRow = 2
        vardescRow = 3
        tbldescRow = 4
    end

    methods
        function self = HeaderInfo(header, iswData)
            if nargin > 0
                self.header = header;
            end
            if nargin > 1
                self.iswData = iswData;
            end
        end
        
        function self = run(self)
            self.FormSpec = FormatSpec(self.header{HeaderInfo.formatRow,:});
            self = self.setTblProp("VariableUnits", HeaderInfo.unitRow);
            self = self.setTblProp("VariableDescriptions", HeaderInfo.vardescRow);
            self = self.setTblDesc(HeaderInfo.tbldescRow);
            self.Props = self.header.Properties;
        end
        
        function delRows = get.delRows(self)
            if self.iswData
                delRows = [self.formatRow, self.unitRow, self.vardescRow, self.tbldescRow];
            else
                delRows = [];
            end
        end
    end
    
    methods (Access = private)
        header = setTblProp(self, propName, headerRow)
        header = setTblDesc(self, headerRow)
        
        function rawRow = getRawHead(self, irow)
            rawRow = string(self.header{irow, :});
            rawRow = strrep(rawRow, self.delChar, "");
        end
    end
end