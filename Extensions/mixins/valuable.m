classdef (HandleCompatible) valuable
    properties (Abstract)
        values (1,:)
    end
    
    methods
        function len = length(self)
            len = length(self.values);
        end
        
        function sz = size(self)
            sz = size(self.values);
        end
        
        function tf = isempty(self)
            tf = isempty(self.values);
        end
    end
    
    methods
        function self = cellfun(func, self, varargin)
            self.values = cellfun(func, self.values, varargin{:});
        end
    end
    
    methods
        function ind = end(self, pos, qty)
            sz = size(self.values);
            if pos < qty
                ind = sz(pos);
            else
                ind = prod(sz(pos:end));
            end
        end
    end
end