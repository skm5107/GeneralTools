classdef Abs
    methods (Static)
        function signedMin = signedmin(vals)
            signedMin = Abs.signed(vals, @min);
        end
        
        function signedMax = signedmax(vals)
            signedMax = Abs.signed(vals, @max);
        end
    end
    
    methods (Static, Access = private)
        function signed = signed(vals, fcnHndl)
            unsigned = abs(vals);
            [val, pos] = fcnHndl(unsigned);
            dir = sign(vals(pos));
            signed = val * dir;            
        end
    end
end