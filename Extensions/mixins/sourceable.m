classdef (HandleCompatible, Abstract) sourceable
    properties (Hidden)
        Orig (1,:)
    end
    
    methods
        function self = setOrig(self, Orig)
            self.Orig = Orig;
            props = setxor(properties(Orig), "Orig");
            self = Obj.props_copy(Orig, self, props);
        end
    end
    
    methods (Abstract)
        self = editOrig(varargin)
    end
end