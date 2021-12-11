classdef WriteTable
    properties
        raw = table()
        header = table()
        filepath (1,1) string = missing
    end
    
    properties (SetAccess = private)
        varnames
        rawStr
        headStr
        totalStr
        total
    end
    
    methods
        function self = WriteTable(raw, header, filepath)
            if nargin > 0
                self.raw = raw;
            end
            if nargin > 1
                self.header = header;
            end
            if nargin > 2
                self.filepath = filepath;
            end
        end
        
        function self = run(self)
            self.varnames = self.getVarnames();
            self.headStr = self.tbl2str(self.header);
            self.rawStr = self.tbl2str(self.raw);
            self.totalStr = [self.headStr; self.rawStr];
            self.total = array2table(self.totalStr, ...
                "VariableNames", self.varnames);
            writetable(self.total, self.filepath);
        end
    end
    
    methods (Access = private)
        function varNames = getVarnames(self)
            if Val.isFull(self.raw)
                varNames = self.raw.Properties.VariableNames;
            else
                varNames = self.header.Properties.VariableNames;
            end
        end
        function tblStr = tbl2str(~, tbl)
            tblCell = table2cell(tbl);
            tblStr = cellfun(@string, tblCell);
        end
    end
end