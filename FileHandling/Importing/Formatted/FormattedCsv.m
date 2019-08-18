classdef FormattedCsv
    % Combination of imported Csv with its header
    %% Properties
    properties (SetAccess = immutable, GetAccess = protected)
        Imported ImportedRaw
        Header AbstHeader = ImportedHeader
    end
    
    properties (SetAccess = private)
        formatted
    end
    
    %% Constructor
    methods
        function self = FormattedCsv(Imported, Header)
            if nargin > 0
                self.Imported = Imported;
            end
            if nargin > 1
                self.Header = Header;
            end
        end
    end
    
    methods
        function [formatted, self] = run(self)
            nometa = FormattedTable(self.Imported.raw, self.Header.ConvertVect).run;
            self.formatted = metaInfo_add(self.Header, nometa);
%             self.formatted(:, ~self.Header.isSaved) = []; %%TODO
            formatted = self.formatted;
            %%TODO columns in 1 variable versus non-comma parsing
        end
    end
end