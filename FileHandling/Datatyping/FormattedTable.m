classdef FormattedTable
    properties (GetAccess = protected)
        raw cell
        FormatVect (1,1) FormatVector
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
                assert(size(self.raw,2) == self.FormatVect.length, "FormattedTable:Vars", "raw width ~= FormatVect length");
            end
        end
        
        function formatted = run(self)
            Var = self.raw;
            for icol = 1:size(Var, 2)
                Var(:, icol) = self.datatype(Var(:, icol), self.FormatVect, icol);
            end
            Var = cellfun(@Val.castMissing, Var, 'uni', false);
            formatted = cell2table(Var);
        end
    end
    
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
                raw = cellfun(@(elem) ihndl(elem, istyle), raw, 'uni', false);
            end
        end
        
        function [raw, hasParsing] = col_parse(raw, iparser)
            if Val.isFull(iparser)
                raw = cellfun(@(elem) Frmt.parse(elem, iparser), raw, 'uni', false);
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