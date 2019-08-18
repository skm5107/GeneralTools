classdef AutoImportKeyed
    %Import any csv as a formatted table using only its KeyedHeader.
    
    % Constructor Inputs
    properties (SetAccess = immutable, GetAccess = protected)
        Header KeyedHeader
        FileName FullPath
    end
    
    properties (SetAccess = private)
        folders
        fileName
        final
    end
    
    properties %(Access = private)
        BodyInfo = BodyImporter
    end
    
    %% Constructor
    methods
        function self = AutoImportKeyed(Header, FileName)
            if nargin > 0
                self.Header = Header;
            end
            if nargin > 1
                Except(FileName).verifyClass("FullPath");
                self.FileName = FileName;
            end
        end
    end
    
    methods
        function [final, self] = run(self)
            self = getFullName(self);
            self.BodyInfo = self.getBodyInfo;
            final = self.getBody;
            self.final = final;
        end
    end
    
    methods (Access = private)
        function self = getFullName(self)
            if Fcn.isFull(self.FileName.fileName)
                self.folders = [self.FileName.topPath, self.FileName.folders];
                self.fileName = self.FileName.fileName;
            else
                self.folders = self.Header.folders;
                self.fileName = self.Header.fileName;
            end
        end
        
        function BodyInfo = getBodyInfo(self)
            filePath = fullfile(self.folders{:}, self.fileName);
            BodyInfo = BodyImporter(filePath, self.Header.nVars);
            BodyInfo.readRow_start = self.Header.headerNrows+1;
        end
        
        function Body = getBody(self)
            [~, Imported] = ImportedRaw(self.BodyInfo).run;
            Body = FormattedCsv(Imported, self.Header).run;
        end
    end
end