classdef (HandleCompatible) multi < valuable
    properties
        values = cell.empty(1,0)
        labels (1,:) = cell.empty(1,0)
    end
    
    methods
        function self = multi(values, labels)
            if nargin > 1
                self.labels = labels;
            end            
            if nargin > 0
                self.values = values;
            end
        end
    end
    
    methods
        function self = set.values(self, values)
            self.values = Arr.cellify(values, 1);
            len = length(self) - length(self.labels); %#ok<*MCSUP>
            self.labels = Arr.pad(self.labels, [1, len], {missing});
        end
        
        function self = set.labels(self, labels)
            self.labels = Arr.cellify(labels, 1);
            self.checkLabelconflicts();
        end
    end
    
    methods
        function multiDims = numel(~, ~)
            multiDims = 1;
        end
        varargout = subsref(self, s)
        self = subsasgn(self, requests, new)
        
        function tf = eq(multiA, multiB)
            tf = isequaln(multiA, multiB);
        end

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
        
        function multed = allLabel(values, label)
            labels = repmat(label, [1, length(values)]);
            multed = multi(values, labels);
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