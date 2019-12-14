classdef (HandleCompatible) tableable
    properties (Hidden)
        rows
    end
    
    methods
        function rows = get.rows(self)
            rows = table();
            for ipos = 1:length(self)
                rows = [rows; self(ipos).getrows]; %#ok<AGROW>
            end
        end
        
        function rows = makerows(self, varargin)
            rows = table();
            for jvar = [varargin{:}]
                rows.(jvar) = reshape(self.(jvar), 1, []);
            end
        end       
    end
end