classdef FormatSpec < FormatVector
    % Intake subclass allowing FormatVector to recieve FormatSpec strings
    
    %% Constructor
    methods
        function self = FormatSpec(formatSpec)
            if nargin > 0
                Except(formatSpec).verifyClass(["string", "char"]);
                [self.formatVect, self.lineEnd] = spec2vect(self, formatSpec);
            end
        end
    end
    
    %% Methods
    methods
        function [formatVect, lineEnd] = spec2vect(self, formatSpec)
            split_vect = strsplit(formatSpec, self.split_char);

            end_vect = Str.getInside(split_vect, self.lineEndBtwn_chars);
            lineEnd = join(end_vect,"");

            formatVect = Str.getOutside(split_vect, self.lineEndBtwn_chars);
            formatVect(formatVect == "") = [];
        end
    end
end