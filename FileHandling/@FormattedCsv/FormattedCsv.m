classdef FormattedCsv < handle
    properties
        pathCsv (1,1) string = missing
        pathHead (1,1) string = missing
    end
    
    properties (Hidden)
        rawSkipRows (1,1) uint8 = 0
        headSkipRows (1,1) uint8 = 0
        Heads HeaderInfo = HeaderInfo()
        
        delimiter = {',' '|'}
        delCol_start = "_"
        commentChar = '#'
    end
    
    properties (SetAccess = private)
        out
    end
    
    properties (Access = private)
        raw
        readSpec
    end
    
    methods
        function self = FormattedCsv(pathCsv, varargin)
            if nargin > 0
                self.pathCsv = pathCsv;
            end
            if nargin > 1
                self = inputparse(varargin);
            end
        end
        
        function [out, self] = run(self)
            self = self.getHeaders();
            csv = readtable(self.pathCsv, 'Delimiter', self.delimiter, ...
                'CommentStyle', self.comment_start, 'HeaderLines', self.rawSkipRows);
            self.raw = self.delExtra(csv);
            self.out = self.setMeta(self.Heads);
            %self.out = NestTable(self.out).run;
            out = self.out;
        end
    end
    
    methods (Access = private)
        Heads = getHeaders(self)
        out = setMeta(self, rawHead)
        out = nestVars(self)
    end
    
    methods (Static, Access = private)
        raw = delExtra(raw)
        %readSpec = countMaxDelimiters(pathCsv)
    end
end

function self = inputparse(varargin)
    
end
