classdef Cylinder
    % Calculations for cylinders
    properties
        diam double
        height double
    end
    
    properties
        vol
        faceArea
    end
    
    methods 
        function self = Cylinder(diam, height)
            if nargin > 0
                self.diam = diam;
            end
            
            if nargin > 1
                self.height = height;
            end
        end
    end
    
    methods
        function vol = get.vol(self)
            vol = self.faceArea * self.height;
        end
        
        function faceArea = get.faceArea(self)
            faceArea = pi * (self.diam/2)^2;
        end
    end
end
