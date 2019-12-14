classdef KeyedHeader < AbstHeader
    % Header information for FormattedCsv as taken from an ImportKey.
    
    properties (SetAccess = immutable, GetAccess = protected)
        Key ImportKey
    end
    
    properties
        wantAlias string
        wantSub string = "" %important for matching default subnames read as ""
    end
    
    properties (Access = protected)
        fileRow
        fileHeaders
    end
    
    properties (SetAccess = {?Cls}) 
        folders
        fileName
        isPartial
        headerNrows
    end
    
    properties (SetAccess = protected)
        varNames
        ConvertVect
        
        varUnits
        varDescs
        tblDesc
        notes
        
        isSaved
        varMult
        
        varNcol
        nVars
    end
    
    %% Constructor
    methods
        function self = KeyedHeader(Key, wantAlias, wantSub)
            if nargin > 0
                self.Key = Key;
            end
            if nargin > 1
                self.wantAlias = wantAlias;
            end
            if nargin > 2
                self.wantSub = wantSub;
            end
        end
    end
    
    methods
        function self = run(self)
            self.fileRow = fileRow_select(self);
            self = Cls.table2class(self.fileRow, self, ["folders", "fileName", "isPartial", "headerNrows"]);
            self.fileHeaders = headers_select(self);
        end
    end
    
    %% Get Key Rows
    methods
        function fileRow = fileRow_select(self)
            alias_inds = false(size(self.Key.files.alias));
            for irow = 1:height(self.Key.files)
                alias_inds(irow) = any(any(self.Key.files.alias{irow} == self.wantAlias'));
            end
            fileRow = subName_select(self, self.Key.files(alias_inds,:));
        end
        
        function fileRow = subName_select(self, aliasRows)
            sub_inds = aliasRows.subName == self.wantSub;
            assert(any(sub_inds), ...
                sprintf("wantAlias + wantSub is not available in Key: %s + %s", self.wantAlias, self.wantSub))
            fileRow = aliasRows(sub_inds, :);
        end
        
        function fileHeaders = headers_select(self)
            header_inds = any(self.Key.headers.alias == string(Arr.uncell(self.fileRow.alias)), 2); %TODO: fix
            fileHeaders = self.Key.headers(header_inds, :);
        end
    end    
    
    %% Getters
    methods        
        function varNames = get.varNames(self)
            varNames = cellstr(self.fileHeaders.varName)';
        end
        function ConvertVect = get.ConvertVect(self)
            ConvertVect = FormatVector(self.fileHeaders.formatSpec');
        end
        function varUnits = get.varUnits(self)
            varUnits = cellstr(self.fileHeaders.varUnits)';
        end
        function varDescs = get.varDescs(self)
            varDescs = cellstr(self.fileHeaders.varDesc)';
        end
        function tblDesc = get.tblDesc(self)
            tblDesc = self.fileRow.notes;
        end
        
        function isSaved = get.isSaved(self)
            isSaved = self.fileHeaders.isSaved;
        end
        function varMult = get.varMult(self)
            varMult = self.fileHeaders.varMult;
            varMult(isnan(varMult)) = 1;
        end
        function notes = get.notes(self)
            notes = cellstr(self.fileHeaders.notes)';
        end
        
        function varNcol = get.varNcol(self)
            varNcol = self.fileHeaders.varNcol;
        end
        function nVars = get.nVars(self)
            nVars = height(self.fileHeaders);
        end
    end
end