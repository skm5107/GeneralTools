classdef Formatter
    properties (GetAccess = private)
        raw
        FormSpec
    end
    
    properties (SetAccess = private)
        out
    end
    
    methods
        function self = Formatter(raw, FormSpec)
            if nargin > 0
                self.raw = raw;
            end
            if nargin > 1
                self.FormSpec = FormSpec;
            end
        end
        
        function out = run(self)
            switch self.FormSpec.typeSpec
                case 'q'
                    hndl = @Frmt.str;
                case 'C'
                  hndl = @Frmt.cat;
                case 'L'
                  hndl = @Frmt.log;
                case 't'
                  hndl = @Frmt.table;
                case 'r'
                  hndl = @Frmt.cell;
                case {'d', 'I', 'u', 'n', 'o', 'x', 'f', 'e', 'E', 'g', 'G'}
                  hndl = @Frmt.num;
                case {'D', 'T'}
                  hndl = @Frmt.clock;
                otherwise
                  error("invalid typeSpec character")
            end
            out = cellfun(hndl, self.raw);
        end
    end
end