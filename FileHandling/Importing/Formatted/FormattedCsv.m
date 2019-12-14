classdef FormattedCsv
    properties (SetAccess = immutable, GetAccess = protected)
        Imported ImportedRaw
        Header AbstHeader = ImportedHeader
    end
    
    methods
        function self = FormattedCsv(Imported, Header)
            if nargin > 0
                self.Imported = Imported;
            end
            if nargin > 1
                self.Header = Header;
            end
        end

        function formatted = run(self)
            nometa = FormattedTable(self.Imported.raw, self.Header.ConvertVect).run;
            formatted = metaInfo_add(self.Header, nometa);
%             self.formatted(:, ~self.Header.isSaved) = []; %%TODO
            %%TODO columns in 1 variable versus non-comma parsing
        end
    end
end