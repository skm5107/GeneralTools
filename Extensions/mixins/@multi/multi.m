classdef (HandleCompatible) multi < valuable
    properties
        values = cell.empty(1,0)
        types (1,:) = cell.empty(1,0)
    end
    
    methods
        function self = multi(values, types)
            if nargin > 1
                self.types = types;
            end            
            if nargin > 0
                self.values = values;
            end
        end
    end
    
    methods
        function self = set.values(self, values)
            self.values = Arr.cellify(values, 1);
            len = length(self) - length(self.types); %#ok<*MCSUP>
            self.types = Arr.pad(self.types, [1, len], {missing}, "right");
        end
        
        function self = set.types(self, types)
            self.types = Arr.cellify(types, 1);
            self.checkTypeconflicts();
        end
    end
    
    methods
        varargout = subsref(self, s)
        self = subsasgn(self, s, b)

        self = horzcat(self, new)
        self = vertcat(self, new)
    end
    
    methods (Access = private)
        checkTypeconflicts(self)
        [prop, requests] = reference(self, requests)
        inds = makeSubs(self, request)
    end
    
    methods (Static)
        out = classCheck(input, reqClass, tfConvert)
        
        function multed = allType(values, type)
            types = repmat(type, [1, length(values)]);
            multed = multi(values, types);
        end
        
        function multed = multify(input)
            if ~ismember("multi", Obj.allclasses(input))
                multed = multi(input);
            else
                multed = input;
            end
        end
    end
end