classdef Sphere
    % Calculations for spheres
    properties
        diam double
    end
    
    properties
        vol
    end
    
    methods 
        function self = Sphere(diam)
            if nargin > 0
                self.diam = diam;
            end
        end
    end
    
    methods
        function vol = get.vol(self)
            vol = 4/3 * pi * (self.diam/2)^3;
        end 
    end
    
    methods (Static)
        function rad = vol2rad(vol)
            rad = (vol / (4/3) / pi) ^ (1/3);
        end
    end
end
