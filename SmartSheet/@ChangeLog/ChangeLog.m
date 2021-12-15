classdef ChangeLog
    properties
        filePath (1,1) string = string(missing)
    end
    
    properties (SetAccess = private)
        raw
        log
        erred
    end
    
    properties (SetAccess = private, Hidden)
        allActions
        allDetTypes
    end
    
    properties (Hidden)
        keepMoves = ["Changed", "Inserted", "Deleted"]
    end
    
    properties (Access = private, Constant)
        headCols = ["Action", "User", "TimeStamp"]
        headDefs = {string(missing), string(missing), NaT}
        headPath = "Activity Log Header.csv";
    end
    
    methods
        function self = ChangeLog(filePath)
            if nargin > 0
                self.filePath = filePath;
            end
        end
        
        function self = run(self)
            self = self.loadRaw();
            self = self.asgnHeads();
            %self = self.trimActions();
            self = self.cleanFormat();
            self = self.getDetails();
        end
    end
    
    methods (Access = private)
        self = loadRaw(self)
        self = asgnHeads(self)
        self = trimActions(self)
        self = getDetails(self)
        
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
