classdef copyable < matlab.mixin.Copyable
    methods
        function arr = copyn(self, qty)
            arr = self;
            for icop = 1:qty-1
                arr = [arr, copy(self)]; %#ok<AGROW>
            end
        end
    end
end