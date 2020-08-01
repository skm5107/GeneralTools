classdef Frmt
    % Static methods for formatting datatypes
    % These are called by function handles in the FormatKey key.
    % They're called with the same handle structure and thus have the same nargin
    
    properties (Constant)
        noType = "X"; %finalID that indicates datatype should be ignored
        defaultTableVar = "Var";
        key = Frmt.loadKey()
    end
    
    methods (Static)
        function val = parse(raw, parseChar)
            clean = strip(raw);
            if ~isempty(parseChar) && parseChar ~= ""
                clean = strip(clean, parseChar);
            end
            val = strip(strsplit(clean, parseChar));
        end
        
        function [val, arg2] = num(raw, ~)
            val = double(string(raw));
            arg2 = missing;
        end
        
        function [val, arg2] = str(raw, ~)
            val = string(raw);
            arg2 = missing;
        end
        
        function [val, arg2] = cat(raw, ~)
            if ~ismissing(raw)
                val = categorical(cellstr(raw));
            else
                val = categorical(raw);
            end
                arg2 = missing;
        end
        
        function [val, arg2] = cell(raw, ~)
            val = num2cell(raw);
            arg2 = missing;
        end
        
        function [val, arg2] = table(raw, ~)
            if ~ismissing(raw)
                val = cell2table(raw);
            else
                val = table(missing);
            end
            arg2 = missing;
        end
        
        function [val, arg2] = clock(raw, style)
            if nargin < 2
                val = datetime(string(raw));
            else
                val = datetime(string(raw), 'InputFormat', style);
            end
            arg2 = missing;
        end
        
        function [val, isAllLog] = lognan(raw, ~)
            % returns a numeric 0, 1, or NaN
            str = lower(string(raw));
            val = nan(size(str));
            val(str == "true" | str == "1") = 1;
            val(str == "false" | str == "0") = 0;
            
            indsLog = val == 0 | val == 1;
            val(~indsLog) = NaN;
            isAllLog = all(indsLog);
        end 
        
        function [val, arg2] = log(raw, ~)
            num = Frmt.num(raw);
            if num == 1
                val = true;
            else
                val = false;
            end
            arg2 = missing;
        end
        
        function [val, arg2] = catTF(log, ~)
            val = categorical(strings(size(log)));
            for ind = 1:length(log(:))
                if log(ind)
                    val(ind) = categorical("true");
                else
                    val(ind) = categorical("false");
                end
                arg2 = missing;
            end
        end
            
        function [val, arg2] = logcat(raw, ~)
            log = Frmt.log(raw);
            val = Frmt.catTF(log);
            arg2 = missing;
        end
    end
    
    methods (Static) %Access = private
        key = loadKey()
    end    
end