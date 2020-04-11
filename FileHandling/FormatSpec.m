classdef FormatSpec
    properties (Hidden)
        rawSpec (1, :) string
    end
    
    properties (Dependent)
        typeSpec
        splitSpec
        styleSpec
    end
    
    properties (Constant, Access = private)
        splitBrack = ["{" "}"]
        styleBrack = ["(" ")"]
    end
    
    methods
        function self = FormatSpec(rawSpec)
            if nargin > 0
                self.rawSpec = rawSpec;
            end
        end
    end
    
    methods
        function typeSpec = get.typeSpec(self)
            typeSpec = Str.getOutside(self.rawSpec, self.splitBrack);
            typeSpec = Str.getOutside(typeSpec, self.styleBrack);
            typeSpec = strip(typeSpec);
        end
        
        function splitSpec = get.splitSpec(self)
            splitSpec = Str.getInside(self.rawSpec, self.splitBrack);
        end
        
        function styleSpec = get.styleSpec(self)
            styleSpec = Str.getInside(self.rawSpec, self.styleBrack);
        end
    end
    
    methods
        function len = length(self)
            len = length(self.rawSpec);
        end
        
        function IndSpec = subsref(self, ref)
            if ref.type == "."
                IndSpec = self.(ref.subs);
            else
                rawRef = subsref(self.rawSpec, ref);
                IndSpec = FormatSpec(rawRef);
            end
        end
    end
end