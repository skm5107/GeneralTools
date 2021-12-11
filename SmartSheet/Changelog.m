classdef Changelog
    properties
        filePath (1,1) string = string(missing)
    end
    
    properties (SetAccess = private)
        raw
    end
    
    methods
        function self = Changelog(filePath)
            if nargin > 0
                self.filePath = filePath;
            end
        end
        
        function self = run(self)
            self = self.loadRaw();
        end
    end
    
    methods
        self = getRaw(self)
        self = asgnHeads(self)
    end
end
        