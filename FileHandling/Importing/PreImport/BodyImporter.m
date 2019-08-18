classdef BodyImporter < AbstImporter
    % Info for textscanning the body of any file
    
    %% Properties
    properties (Access = public)
        readRow_end = inf;
        nVars
        
        comment_style
    end
    
    %% Constructor
    methods
        function self = BodyImporter(path, nVars, readRow_start, readRow_end)
            if nargin < 1
                path = [];
            end
            self = self@AbstImporter(path);
            if nargin > 1 && ~isempty(nVars)
                self.nVars = nVars;
            end
            
            if nargin > 2 && ~isempty(readRow_start)
                self.readRow_start = readRow_start;
            end
            
            if nargin > 3 && ~isempty(readRow_end)
                self.readRow_end = readRow_end;
            end
            
            self.comment_style = self.strip_char;
        end
    end
end