classdef FormatVector
    %Various views of datatype information in an extension of MATLAB's textscan format.
    %TODO: class that's fully readable by textscan plus an extension class?
    
    properties (SetAccess = protected)
        formatVect string
        lineEnd = "[^\n\r]";
    end
    
    properties (Dependent, SetAccess = protected)
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
    
    % MATLAB FormatSpec Design
    properties (Constant, Access = protected)
        customBtwn_chars = ["{", "}"];
        lineEndBtwn_chars = ["[", "]"];
        split_char = '%';
    end
    
    %% Constructor
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
    
    %% FormatSpec Getters
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
                styleElem = self.brackets_append(self.styleVect(iid), self.customBtwn_chars);
                scanVect(iid) = styleElem + self.idVect(iid);
            end
        end
    end
    
    %% Custom Format Getters
    methods
        function idVect = get.idVect(self)
            idVect = Str.getOutside(self.formatVect, self.customBtwn_chars);
        end
        
        function custVect = get.custVect(self)
            custVect = Str.getInside(self.formatVect, self.customBtwn_chars);
            custVect = strip(custVect, 'both', self.customBtwn_chars(1));
            custVect = strip(custVect, 'both', self.customBtwn_chars(2));
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
    
    %% Get Key Reference
    methods
        function ref = get.ref(self)
            for iid = 1:length(self.idVect)
                ref(iid, :) = Key.lookup(FormatKey.key, self.idVect(iid), "finalID"); %#ok<AGROW>
            end
        end
    end
    
    %% Setters
    methods
        function self = set.formatVect(self, formatVect)
            self.formatVect = string(formatVect);
        end
        
        function self = set.lineEnd(self, lineEnd)
            if ~isempty(lineEnd) && lineEnd ~= "" && ~contains(lineEnd, self.lineEndBtwn_chars)
                lineEnd = self.lineEndBtwn_chars(1) + lineEnd + self.lineEndBtwn_chars(2);
            end
            self.lineEnd = string(lineEnd);
        end
    end
    
    
    %% Overload Methods
    methods
        function len = length(self)
            len = length(self.formatVect);
        end
    end
    
    %% Internal Methods
    methods (Static, Access = protected) 
        function bracketed = brackets_append(elem, brackets)
            if  elem ~= ""
                bracketed = brackets{1} + elem + brackets{2};
            else
                bracketed = "";
            end
        end
        

        
        function split = cust_split(elem, choice) %%TODO: unhack
            elem = char(elem);
            if elem == ""
                style = "";
                parser = "";
            elseif string(elem(end)) == Str.letter_get(elem(end))
                style = string(elem);
                parser = "";
            else
                style = string(elem(1:end-1));
                parser = string(elem(end));
            end
            
            if choice == "parser"
                split = parser;
            else
                split = style;
            end
        end
    end    
end