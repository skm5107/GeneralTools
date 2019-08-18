classdef HeaderImporter < AbstImporter
    % Info for textscanning any file header
    
    %% Properties
    properties (Access = public)
        comment_style = '';
        headerRows = {'VariableNames', 'VariableTypes', ...
                      'VariableUnits', 'VariableDescriptions', ...
                      'Description'};
    end
    
    properties (Dependent, SetAccess = private)
        nVars
        readRow_end
    end
    
    %% Constructor
    methods
        function self = HeaderImporter(path)
            if nargin < 1
                path = [];
            end
            self = self@AbstImporter(path);
        end
    end
    
    %% Setters
    methods
        function nVars = get.nVars(self)
            line1 = ImportedRaw.line_read(self.path, self.readRow_start);
            splitCols = strsplit(line1, self.delimiter);
            nVars = length(splitCols);
        end
        function read_irows = get.readRow_end(self)
            read_irows = self.readRow_start + length(self.headerRows)-1;
        end
    end    
end