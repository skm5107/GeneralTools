classdef FormattedCsv
    properties
        pathRaw (1,1) string
        pathHeader (1,1) string = string(missing)
        
        headerRows (1,1) double = 5
        rawSkipRows (1,1) double = 0
        
        opts = FormattedCsv.defaultOpts
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
        headProps = ["FormSpec", ...
            "VariableUnits", "VariableDescriptions", ...
            "Description"];
        headOpts = ["VariableNamesLine", "FormSpec", ...
            "VariableUnitsLine", "VariableDescriptionsLine", ...
            "Description"];
        defaultOpts = FormattedCsv.loadDefaultOpts()
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
            [self, metad] = self.formatMeta();
        end
    end
    
    methods (Access = private)
        opts = setHeadOpts(self)
        self = loadHeader(self)
        self = loadRaw(self)
        self = makeProps(self)
        [self, metad] = formatMeta(self)
    end
    
    methods (Static, Access = private)
        opts = loadDefaultOpts()
    end
end
