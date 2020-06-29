classdef (HandleCompatible) valuable
    properties (Abstract)
        values (1,:)
    end
    
    methods
        function len = length(self)
            len = length(self.values);
        end
        
        function tf = isempty(self)
            if any(size(self) == 0)
                tf = true;
            else
                tf = isempty(self.values);
            end
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