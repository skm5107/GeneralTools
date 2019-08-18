classdef Trapz %< Shape
    % Calculations for trapezoids
    methods (Static)
        function A = area(height1, height2, width)
            A = (height1 + height2)*(width/2);
        end
    end
end
