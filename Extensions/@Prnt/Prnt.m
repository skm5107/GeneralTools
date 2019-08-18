classdef Prnt
    % Static methods for printing to screen
    
    methods (Static)
        count = cprintf(style,format,varargin) % Colorize
        tex = table2latex(T, filename);
    end
    
    %% Conditional Printing
    properties (Constant) %%TODO: constant if object doesn't exist?
        tier = 0
    end
    
    methods (Static)
        function iprintf(str, str_tier)
            if nargin < 2
                str_tier = 1;
            end
            if str_tier <= Prnt.tier
                fprintf(str)
            end
        end
    end
    
    %% Labeling
    methods (Static)
        function labeled = label(structORtbl)
            varNames = Fcn.varlist(structORtbl);
            labeled = strings([length(varNames) 2]);
            for ivar = 1:length(varNames)
                labeled(ivar, 1) = string(varNames{ivar});
                labeled(ivar, 2) = string(structORtbl.(varNames{ivar}));
            end
        end
    end
    
    %% Array Printing
    methods (Static)
        function prnt = vectprintf(vect, parser)
            if nargin < 2 || isempty(parser)
                parser = " ";
            else
                parser = string(parser);
            end
            single = strcat('%s' + parser);
            format = repmat(char(single), 1, length(vect));
            
            prnt = sprintf(format, string(vect));
            prnt = prnt(1:end-length(char(parser)));
            prnt = strip(prnt);
        end
    end
    
    %% Shorthand Printers
    methods (Static)
        function yes(varargin)
            switch length(varargin)
                case 0
                    fprintf("Condition is true.\n")
                case 1
                    fprintf(sprintf("Condition is true: %g.\n", varargin{1}))
                case 2
                    fprintf(sprintf("Condition is true: %g.\n", varargin{1}), varargin{2}) %TODO: support iprintf
            end
        end
    end
    
    %% PrintF helpers
    methods (Static)
        function path_prnt = path(path_str)
            %doubles the "/" or "\" from fullfile in order to print correctly in sprintf
            if isempty(path_str)
                path_str = "emptyPathName";
            end
            parsed = strsplit(path_str, "\");
            path_prnt = join(parsed(:), "\\");
            
            parsed = strsplit(path_prnt, "\");
            path_prnt = join(parsed(:), "\\");
        end
    end
end