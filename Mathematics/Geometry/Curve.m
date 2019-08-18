classdef Curve
    % Curve objects
    methods (Static)
        function y = yFROMmxb(m, x, b)
            y = m .* x + b;
        end
        
        function [m, b] = mbFROMxyxy(x1, y1, x2, y2)
            m = (y2 - y1) ./ (x2 - x1);
            b = (x2 .* y1 - x1 .* y2) ./ (x2 - x1);
        end
    end
end