classdef FormattedCsv
    properties
        pathRaw (1,1) string
        pathHeader (1,1) string = string(missing)
        
        headerRows (1,1) double = 5
        rawSkipRows (1,1) double = 0
    end
    
    properties (SetAccess = private)
        metad
    end
    
    properties (Access = private)
        header
        raw
        Heads
        FormSpec
    end
    
    properties (Access = private, Constant)
        headRows = ["FormSpec", "VariableUnits", ...
                    "VariableDescriptions", "Description"];
    end
    
    methods
        function self = FormattedCsv(pathRaw, pathHeader)
            if nargin > 0
                self.pathRaw = pathRaw;
            end
            if nargin > 1 && Val.isFull(pathHeader)
                self.pathHeader = pathHeader;
            end
        end
        
        function [metad, self] = run(self)
            self = self.loadHeader();
            self = self.loadRaw();
            
            self = self.makeProps();
            metad = table();
            if ~isempty(self.FormSpec)
                for icol = 1:width(self.raw)
                    varName = self.raw.Properties.VariableNames{icol};
                    if varName == "Row"
                        varName = "RowReNamed";
                    end
                    newCol = Formatter(self.raw{:,icol}, self.FormSpec{icol}).run;
                    metad.(varName) = newCol;
                end
            else
                metad = self.raw;
            end
            if ~isempty(self.Heads)
                metad.Properties = self.Heads;    
            end
        end
    end
    
    methods (Access = private)
        self = loadRaw(self)
        self = loadHeader(self)
        
        self = makeProps(self)
    end
end
