classdef AutoImported
    properties
        path (1,1) string
        headerRows cell
        comment_style (1,1) string
        commentHeader_style (1,1) string
        readRow_end (1,1) double
    end
    
    properties (Access = private)
        HeadInfo = HeaderImporter
        BodyInfo = BodyImporter
        Header = ImportedHeader
        Body = FormattedCsv
    end
    
    methods
        function self = AutoImported(path)
            if nargin > 0
                self.path = path;
            end
        end

        function final = run(self)
            self.HeadInfo = self.getHeadInfo();
            self.BodyInfo = self.getBodyInfo();
            rawHead = ImportedRaw(self.HeadInfo).run;
            self.Header = ImportedHeader(rawHead);
            self.Body = ImportedRaw(self.BodyInfo).run;
            final = FormattedCsv(self.Body, self.Header).run;
        end
    end
    
    methods (Access = private)
        function HeadInfo = getHeadInfo(self)
            HeadInfo = HeaderImporter(self.path);
            if ~isempty(self.headerRows)
                HeadInfo.headerRows = self.headerRows;
            end
            if ~isempty(self.commentHeader_style)
                HeadInfo.comment_style = self.commentHeader_style;
            end
        end
        
        function BodyInfo = getBodyInfo(self)
            BodyInfo = BodyImporter(self.path, self.HeadInfo.nVars);
            BodyInfo.readRow_start = self.HeadInfo.readRow_end+1;
            if ~isempty(self.readRow_end)
                BodyInfo.readRow_end = self.readRow_end;
            end
            if ~isempty(self.comment_style)
                BodyInfo.comment_style = self.comment_style;
            end            
        end        
    end
end