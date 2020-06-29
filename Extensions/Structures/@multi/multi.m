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
            self.checkLabelConflicts();
        end
    end
    
    methods
        function multiDims = numel(~, ~)
            multiDims = 1;
        end        
        function tf = eq(multiA, multiB)
            tf = isequaln(multiA, multiB);
        end

        varargout = subsref(self, s)
        self = subsasgn(self, requests, new)
        
        self = horzcat(self, new)
        self = vertcat(self, new)
    end
        
    methods (Access = private)
        checkLabelConflicts(self)
        [prop, requests] = reference(self, requests)
        inds = makeSubs(self, request)
    end
    
    methods (Static)
        function out = missing()
            out = multi(missing);
        end
        out = propCheck(multiORvals, reqClass, minmaxDims, tfConvert)
        multed = allLabel(values, label)
        multed = multify(input)
    end
end