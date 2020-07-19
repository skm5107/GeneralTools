classdef HeaderInfo < handle
    properties (Hidden)
        header
        iswData (1,1) logical = true
        delChar (1,1) string = "#"
        key = HeaderInfo.loadKey()
    end
    
    properties (SetAccess = private)
        Props
        FormSpec (1,1) FormatSpec
    end
    
    properties (Access = private)
        convertHndl
    end
    
    properties (Dependent)
        delRows
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
                self.key.csvRow(1:length(headerRows)) = headerRows;
            end
        end
        
        self = run(self)
                
        function delRows = get.delRows(self)
            if self.iswData
                delRows = self.key.csvRow(1:end-1);
            else
                delRows = [];
            end
        end
    end
    
    methods (Static, Access = private)
        key = loadKey()
    end
end