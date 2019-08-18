classdef AutoConst
    % Automatic constant loading from requested folder and file identifiers
    
    properties (SetAccess = immutable)
        IDs ConstIDs
    end
    
    properties (Access = private)
        folderMap
        fileMap
        
        Header
    end
    
    properties (SetAccess = private)
        const
    end
    
    properties (Constant, Access = private)
        headerAlias = "const";
    end
    
    %% Constructor & AutoGetter
    methods
        function self = AutoConst(IDs)
            if nargin > 0
                self.IDs = IDs;
            end
        end
    end
    
    methods
        function [const, self] = run(self)
            self.folderMap = ConstMapper(self.IDs.constFolders).run;
            self.fileMap = ConstRequestor(self.IDs.constFiles, self.folderMap).run;
            self.Header = KeyedHeader(ImportKey(self.IDs.projID).run, self.headerAlias).run;
            const = ConstSet(self.fileMap, self.Header).run;
            self.const = const;
        end
    end
end