classdef ChangeLog
    properties
        filePath (1,1) string = string(missing)
    end
    
    properties (SetAccess = private)
        raw
        log
        
        allActions
    end
    
    properties (Hidden)
        keepMoves = ["Changed", "Inserted", "Deleted"]
    end
    
    properties (Access = private, Constant)
        headCols = ["Action", "User", "TimeStamp"]
        headDefs = {string(missing), string(missing), NaT}
    end
    
    methods
        function self = ChangeLog(filePath)
            if nargin > 0
                self.filePath = filePath;
            end
        end
        
        function self = run(self)
            %self = self.loadRaw();
            self = self.asgnHeads();
            self = self.trimActions();
            self = self.cleanFormat();
            %self = self.parseDetails();
        end
    end
    
    methods %(Access = private)
        self = loadRaw(self)
    end
    
    methods (Access = private)
        self = asgnHeads(self)
        self = trimActions(self)
        self = parseDetails(self)
        
        function self = cleanFormat(self)
            self.log.Action = [];
            self.log.User = [];
        end
    end
    
    methods (Access = public)
        self = checkActions(self)
        self = checkDetails(self)
    end
end