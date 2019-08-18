classdef AbstImporter < handle
    % Superclas for Info object to textscan any file
    
    %% Properties
    properties (Access = public)
        path
        readRow_start = 1;
    end
    
    properties (Abstract)
        comment_style;
    end
    
    properties (Access = public)
        strip_char = '#';
        import_id = "q";
        delimiter = ',';
        
        text_type = 'string';
        lineEnd = "^\r\n";
        
        print_tier = 0;
    end
    
    properties (Dependent, SetAccess = private)
        import_spec
    end
    
    %% Constructor
    methods
        function self = AbstImporter(path)
            if nargin > 0 && ~isempty(path)
                self.path = path;
            end
        end
    end
        
    %% Methods
    methods
        function import_spec = get.import_spec(self)
            ImportVect = FormatVector(repmat(self.import_id, [1 self.nVars]), self.lineEnd);
            import_spec = ImportVect.formatSpec;
        end
    end
    
    %% Setter
    methods
        function self = set.import_id(self, import_id)
            self.import_id = string(import_id);
        end
    end
end