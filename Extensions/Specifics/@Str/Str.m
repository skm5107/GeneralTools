classdef Str    
    methods (Static)
        function len = length(str)
            if ~Num.isnum(str)
                len = length(char(str));
            else
                len = length(num2str(str));
            end
        end
    end

    methods (Static)
        [ind, match_frac] = closestMatch(strVect, str)
        [isMatch, start_inds, nextChars] = findNextChar(str, patterns, nextChar)
        
        function ind = findNum(str, varargin)
            nums = char(str) - '0';
            ind = find(nums >= 0 & nums < 10, varargin{:});
        end  
        
        function tf = ischar(strORchar)
            tf = isstring(strORchar) || ischar(strORchar);
        end
    end    
    
    methods (Static)
        out = eraseAny(orig, dels)
        str = eraseBtwn(str, startStr, endStr, boundaries)
        
        function [erased, tf] = eraseIf(str, match)
            erased = erase(str, match);
            tf = cellfun(@Str.length, erased) < cellfun(@Str.length, str);
        end
    end
    
    %% Vector Operations
    methods (Static)
        function inds = strfind(str, patterns)
            inds = nan([1, length(patterns)]);
            for ipatt = 1:length(patterns)
                iind = strfind(str, patterns(ipatt));
                iind(isempty(iind)) = NaN;
                inds(ipatt) = iind;
            end
        end
        
        function splits = split(strs, delimiter)
            strs = string(strs);
            splits = cell(size(strs));
            for istr = 1:length(strs)
                splits{istr} = strsplit(strs(istr), delimiter);
            end
        end
        
        function varargout = splitDeal(varargin)
            splitted = split(varargin{:});
            pad = repmat("", nargout - length(splitted));
            varargout = num2cell([splitted, pad]);
        end
            
    end
    
    methods (Static)
        function tf = contains(strVect, str)
            tf = Str.strloop(strVect, str, @contains);
        end
        function tf = startsWith(strVect, str)
            tf = Str.strloop(strVect, str, @startsWith);
        end
        function tf = endsWith(strVect, str)
            tf = Str.strloop(strVect, str, @endsWith);
        end
    end
    
    %% Value-Related Operations
    methods (Static)
        [letts, cells] = getLetts(str)
        [nums, cells] = getNums(str)
        
        inside = getInside(txt, btwn_chars)
        outside = getOutside(txt, btwn_chars)
        function [inside, outside] = getInOut(txt, btwn_chars)
            inside = Str.getInside(txt, btwn_chars);
            outside = Str.getOutside(txt, btwn_chars);
        end

        strred = type2str(val)
        
        function capped = upper1(str)
            charred = char(str);
            charred(:,1) = upper(charred(:,1));
            capped = string(charred);
        end
    end
    
    %% Internals
    methods (Static, Access = private)
        [text, start_ind, end_ind] = inds_find(text, btwn_chars)
        tf = strloop(strVect, str, hndl)
    end
end