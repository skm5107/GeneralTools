classdef ImportedRaw
    properties
        Info (1,1) AbstImporter = BodyImporter;
    end
    
    properties (SetAccess = private)
        raw
    end

    methods
        function self = ImportedRaw(Info)
            if nargin > 0
                self.Info = Info;
            end
        end
        
        function [self, raw] = run(self)
            Except(self.Info.path).verifyFileOpens;
            file_hndl = fopen(self.Info.path,'r');
            
            raw = textscan(file_hndl, self.Info.import_spec, ... 
                self.Info.readRow_end - self.Info.readRow_start+1, ...
                'Delimiter', self.Info.delimiter, ...
                'TextType', self.Info.text_type, ...
                'HeaderLines', self.Info.readRow_start-1, ...
                'ReturnOnError', false, ...
                'EndOfLine', erase(self.Info.lineEnd, "^"), ...
                'CommentStyle', self.Info.comment_style);            
            fclose(file_hndl);
            
            raw = cellstr([raw{1,1:end-1}]);
            self.raw = raw;
        end
    end
    
    methods (Static)
        function line = line_read(path, iline)
            if nargin < 2
                iline = 1;
            end
            
            Except(path).verifyFileOpens;
            file_hndl = fopen(path, 'r');
            for i = 1:iline
                line = fgetl(file_hndl);
            end
            fclose(file_hndl);
        end
    end    
end