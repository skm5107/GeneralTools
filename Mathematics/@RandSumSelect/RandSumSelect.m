classdef RandSumSelect
    properties
        wantSum (1,1) double
        names (:,:) string
    end
    
    properties (Dependent)
        hgt
        wid
    end
    
    properties (SetAccess = private)
        selectees string
    end
    
    properties (Hidden)
        wantFcn (1,1) function_handle = @eq
        weighter (1,1) uint8 = 1
        maxTry (1,1) uint8 = 10000        
    end
        
    properties (Access = private)
        wghtd (:,:) double
    end
    
    methods
        function self = RandSumSelect(raw, names)
            if nargin > 0
                self.wghtd = repmat(raw, [self.weighter, 1]);
            end
            if nargin > 1
                self.names = repmat(names, [self.weighter, 1]);
                assert(all(size(self.names) == size(self.wghtd)), "input:names", "provide name for each value")
            end
        end
        
        function self = run(self, wantSum, qty)
            self.wantSum = wantSum;
            if nargin < 3
                qty = 1;
            end
            for isel = 1:qty
                [iinds, self.selectees(isel,:)] = self.singleSelect();
                self = self.singleClean(iinds);
            end
        end
    end
    
    methods   
        function self = set.weighter(self, weighter)
            self.weighter = weighter;
            self.wghtd = repmat(self.wghtd, [self.weighter, 1]); %#ok<MCSUP>
            self.names = repmat(self.names, [self.weighter, 1]); %#ok<MCSUP>
        end
        function hgt = get.hgt(self)
            hgt = size(self.wghtd, 1);
        end
        
        function wid = get.wid(self)
            wid = size(self.wghtd, 2);
        end
    end
    
    
    methods (Access = private)
        [iinds, iselects] = singleSelect(self)
        self = singleClean(self, iinds)
    end
end