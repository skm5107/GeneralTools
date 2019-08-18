classdef ImportedRaw
    % Get raw CSV rows using Importer object
    % Includes a static external method for reading a given line of a file
    
    properties
        Info AbstImporter = BodyImporter;
    end
    
    properties (SetAccess = private) %Frozen Output
        raw
    end
    
    %% Constructor
    methods
        function self = ImportedRaw(Info)
            if nargin > 0
                self.Info = Info;
            end
        end
    end
    
    %% Runner
    methods
        function [raw, self] = run(self)
            Except(self.Info.path).verifyFileOpens;
            file_hndl = fopen(self.Info.path,'r');
            
            self.raw = textscan(file_hndl, self.Info.import_spec, ... 
                self.Info.readRow_end - self.Info.readRow_start+1, ...
                'Delimiter', self.Info.delimiter, ...
                'TextType', self.Info.text_type, ...
                'HeaderLines', self.Info.readRow_start-1, ...
                'ReturnOnError', false, ...
                'EndOfLine', erase(self.Info.lineEnd, "^"), ... %%TODO: unclear why MATLAB wants this
                'CommentStyle', self.Info.comment_style);
            %TODO: go to reading all and deleted commented items to avoid losses from # mid-line
            %TODO: strip % or another char from between delimiters in order to ensure each cell is found full
            %TODO: add header item as rules to check (int, nonnegs, etc)
            
            fclose(file_hndl);
            
            self.raw = cellstr([self.raw{1,1:end-1}]);
            raw = self.raw;
        end
    end
    
    %% Open Methods
    methods (Static)
        function line = line_read(path, iline) %%TODO unit test
            % Read only the ith line of any filepath
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