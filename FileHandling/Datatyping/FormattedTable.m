classdef FormattedTable
    % Raw imported array converted to table with requested datatypes
    
    properties (SetAccess = immutable, GetAccess = protected)
        raw cell
        FormatVect FormatVector
    end
    
    properties (SetAccess = private)
        formatted
    end
    
    methods
        function self = FormattedTable(raw, FormatVect)
            if nargin > 0
                self.raw = raw;
            end
            if nargin > 1
                self.FormatVect = FormatVect;
                Except(size(self.raw,2)).verifyEqual(self.FormatVect.length, "raw width vs FormatVect length");
            end
        end
    end
    
    methods
        function [formatted, self] = run(self)
            Var = self.raw; %sets MATLAB default variable names %%TODO: move to MATLAB constants
            for icol = 1:size(Var, 2)
                Var(:, icol) = self.datatype(Var(:, icol), self.FormatVect, icol);
            end
            self.formatted = cell2table(Var);
            formatted = self.formatted;
        end
    end
    
    %% Methods
    methods (Static, Access = private)
        function raw = datatype(raw, FormatVect, icol)
            iparser = FormatVect.parseVect(icol);
            istyle = FormatVect.styleVect(icol);
            
            [raw, hasParsing] = FormattedTable.col_parse(raw, iparser);
            
            if contains(FormatVect.formatVect(icol), Frmt.noType)
                return
            elseif ~hasParsing
                ihndl = FormatVect.ref.fcnHndl{icol};
                raw = FormattedTable.fastConvert(raw, ihndl, istyle);
            else
                ihndl = FormatVect.ref.fcnHndl{icol};
                raw = cellfun(@(elem) ihndl(elem, istyle), raw, 'UniformOutput', 0);
            end
        end
        
        function [raw, hasParsing] = col_parse(raw, iparser)
            if Fcn.isFull(iparser)
                raw = cellfun(@(elem) Frmt.parse(elem, iparser), raw, 'UniformOutput', 0);
                hasParsing = true;
            else
                hasParsing = false;
            end            
        end
        
        function raw = fastConvert(raw, ihndl, istyle)
            [raw, isLog] = ihndl(raw, istyle);
            if func2str(ihndl) == "Frmt.lognan" && isLog
                raw = logical(raw);
            end
            raw = num2cell(raw);
        end
    end
end