classdef ConstIDs
    properties (SetAccess = private)        
        constFolders string
        constFiles string
    end
    
    properties
        genID
        projID
        rulesID
        
        metaIDs
        caseIDs
    end
    
    methods
        function self = ConstIDs(genID, projID, rulesID, metaIDs)
            if nargin > 0
                self.genID = genID;
            end
            if nargin > 1
                self.projID = projID;
            end
            if nargin > 2
                self.rulesID = rulesID;
            end
            if nargin > 3
                self.metaIDs = metaIDs;
            end
        end
        
        %% Runner for a Particular Case
        function self = run(self, caseIDs)
            if nargin > 1
                self.caseIDs = caseIDs;
            end

            self.constFolders = ["", self.genID, ...
                   self.projID, self.rulesID, ...
                   self.metaIDs];
               
            self.constFiles = [self.constFolders, self.caseIDs];
            self.constFiles(self.constFiles == "") = [];
        end
    end
end