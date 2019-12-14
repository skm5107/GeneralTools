classdef (HandleCompatible) multi
    properties
        values (1,:) = cell.empty(1,0)
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
            self.values = Arr.cellify(values);
            len = length(self) - length(self.types); %#ok<*MCSUP>
            self.types = Arr.pad(self.types, [1, len], {missing}, "right");
        end
        function self = set.types(self, types)
            self.types = Arr.cellify(types);
        end
    end
    
    methods
        varargout = subsref(self, s)
        self = subsasgn(self, s, b)
        
        function ind = end(self, pos, qty)
            sz = size(self.values);
            if pos < qty
                ind = sz(pos);
            else
                ind = prod(sz(pos:end));
            end
        end
    end
    
    methods
        function self = temp1(self)
            self(1)
        end
        
        self = horzcat(self, new)
        self = vertcat(self, new)
        
        function len = length(self)
            len = length(self.values);
        end
    end
    
    methods (Access = private)
        inds = getSubs(self, request, checkType)
        [tfStruct, structFld] = checkAsStruct(request, allowFlds)
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