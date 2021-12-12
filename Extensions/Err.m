classdef Err
    properties
        isError
        value
        errArgs
    end
    
    properties (Constant, Hidden)
        heading = "Errored Value:\n"
    end
    
    methods
        function self = Err(isError, value, varargin)
            if nargin > 0
                self.isError = isError;
            end
            if nargin > 1
                self.value = value;
            end
            if nargin > 2
                self.errArgs = varargin;
            end
        end
        
        function self = run(self)
            if self.isError
                fprintf(Err.heading);
                disp(self.value);
                error(self.errArgs{:});
            end
        end
    end
end
            