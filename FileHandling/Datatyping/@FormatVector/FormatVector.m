classdef FormatVector
    properties (SetAccess = protected)
        formatVect (1,:) string
        lineEnd (1,1) string = "[^\n\r]"
    end
    
    properties (Dependent)
        formatSpec
        ref
        
        idVect
        styleVect
        parseVect
    end
    
    properties (Dependent, Access = private)
        custVect
        scanVect
    end
    
    properties (Constant, Access = protected)
        custBtwn_chars = ["{", "}"];
        lineEndBtwn_chars = ["[", "]"];
        split_char = '%';
    end
    
    methods
        function self = FormatVector(formatVect, lineEnd)
            if nargin > 0
                self.formatVect = formatVect;
            end
            
            if nargin > 1 && ~isempty(lineEnd)
                self.lineEnd = lineEnd;
            end
        end
    end
    
    methods
        function formatSpec = get.formatSpec(self)
            if ~isempty(self.lineEnd) && self.lineEnd ~= ""
                self.lineEnd = self.split_char + self.lineEnd;
            end
            formatSpec = self.split_char + strjoin(self.scanVect, self.split_char) + self.lineEnd;
        end
        
        function scanVect = get.scanVect(self)
            scanVect = strings(size(self.styleVect));
            for iid = 1:length(self.styleVect)
                styleElem = self.brackets_append(self.styleVect(iid), self.custBtwn_chars);
                scanVect(iid) = styleElem + self.idVect(iid);
            end
        end
    end
    
    methods
        function idVect = get.idVect(self)
            idVect = Str.getOutside(self.formatVect, self.custBtwn_chars);
        end
        
        function custVect = get.custVect(self)
            custVect = Str.getInside(self.formatVect, self.custBtwn_chars);
            custVect = strip(custVect, 'both', self.custBtwn_chars(1));
            custVect = strip(custVect, 'both', self.custBtwn_chars(2));
        end
        
        function styleVect = get.styleVect(self)
            styleVect = cellfun(@(cust) self.cust_split(cust, "style"), cellstr(self.custVect));
            if isempty(styleVect)
                styleVect = "";
            end
        end
        
        function parseVect = get.parseVect(self)
            parseVect = cellfun(@(cust) self.cust_split(cust, "parser"), cellstr(self.custVect));
            if isempty(parseVect)
                parseVect = "";
            end
        end
    end
    
    methods
        function ref = get.ref(self)
            for iid = 1:length(self.idVect)
                ref(iid, :) = Key.lookup(FormatKey.key, self.idVect(iid), "finalID"); %#ok<AGROW>
            end
        end
    end
    
    methods
        function self = set.lineEnd(self, lineEnd)
            if ~isempty(lineEnd) && lineEnd ~= "" && ~contains(lineEnd, self.lineEndBtwn_chars)
                lineEnd = self.lineEndBtwn_chars(1) + lineEnd + self.lineEndBtwn_chars(2);
            end
            self.lineEnd = string(lineEnd);
        end
    end
    
    
    methods
        function len = length(self)
            len = length(self.formatVect);
        end

        function colInfo = col(self, colNum)
            colInfo.formatter = self.formatVect(colNum);
            colInfo.styler = self.styleVect(colNum);
            colInfo.parser = self.parseVect(colNum);
            colInfo.fcnHndl = self.ref.fcnHndl{colNum};
        end        
    end
    
    methods (Static, Access = protected)
        split = cust_split(elem, choice)
        
        function bracketed = brackets_append(elem, brackets)
            if  elem ~= ""
                bracketed = brackets{1} + elem + brackets{2};
            else
                bracketed = "";
            end
        end
    end
end