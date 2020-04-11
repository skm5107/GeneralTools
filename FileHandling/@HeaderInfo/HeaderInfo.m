classdef HeaderInfo < handle
    properties (Hidden)
        header
        iswData (1,1) logical = true
    end
    
    properties (SetAccess = private)
        Props
        FormSpec
    end
    
    properties (Dependent)
        delRows
    end
    
    properties (Hidden)
        delChar (1,1) string = "#"
        formatRow (1,1) double = 1
        unitRow (1,1) double = 2
        vardescRow (1,1) double = 3
        tbldescRow (1,1) double = 4
    end
    
    methods
        function self = HeaderInfo(header, iswData, headerRows)
            if nargin > 0
                self.header = header;
            end
            if nargin > 1
                self.iswData = iswData;
            end
            if nargin > 2
                headerRows = num2cell([headerRows, nan(1, 4-length(headerRows))]);
                [self.formatRow, self.unitRow, self.vardescRow, self.tbldescRow] = deal(headerRows{:});
            end
        end
        
        function self = run(self)
            if ~isnan(self.formatRow)
                self.FormSpec = FormatSpec(self.header{self.formatRow,:});
            end
            self = self.setTblProp("VariableUnits", self.unitRow);
            self = self.setTblProp("VariableDescriptions", self.vardescRow);
            self = self.setTblDesc(self.tbldescRow);
            self.Props = self.header.Properties;
        end
        
        function delRows = get.delRows(self)
            if self.iswData
                delRows = [self.formatRow, self.unitRow, self.vardescRow, self.tbldescRow];
                delRows(isnan(delRows)) = [];
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