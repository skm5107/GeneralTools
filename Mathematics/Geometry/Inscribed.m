classdef Inscribed
    methods (Static)
        function diam = sphereINrec(wid, hgt, dep)
            diag = sqrt(wid^2 + hgt^2 + dep^2);
            diam = diag;
        end
    end
    
end