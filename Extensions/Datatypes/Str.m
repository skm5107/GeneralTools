classdef Str
    % Static methods for strings
    
    %% Vector Ops
    methods (Static)
        function [ind, match_frac] = closestMatch(strVect, str)
            match_frac = nan(size(strVect));
            tot_char = length(char(str));
            for istr = 1:length(strVect)
                remainder = erase(str, strVect(istr));
                remain_char = length(char(remainder));
                match_frac(istr) = (tot_char - remain_char) / tot_char;
            end
            match_frac(match_frac > 1) = NaN;
            [~, ind] = nanmax(match_frac);
        end
        
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
    
    methods (Static, Access = private)
        function tf = strloop(strVect, str, hndl)
            tf = false(size(strVect));
            for istr = 1:length(strVect)
                tf(istr) = hndl(str, strVect(istr)) || hndl(strVect(istr), str);
            end
        end
    end
    
    %% Join & Split
    methods (Static)
        function splits = strsplit(strs, delimiter)
            strs = string(strs);
            splits = cell(size(strs));
            for istr = 1:length(strs)
                splits{istr} = strsplit(strs(istr), delimiter);
            end
        end
        
        function joined = join(strs, joiner, delNaN)
            strs = string(strs);
            
            if nargin < 3 || ~delNaN
                strs(ismissing(strs)) = "";
            else
                strs(ismissing(strs)) = [];
            end
            
            if nargin < 2
                joined = join(strs);
            else
                joined = join(strs, joiner);
            end
        end
    end
    
    methods (Static)
        function out = splitJoin(txt, parser, inds, fromEnd)
            if isempty(txt)
                txt = "";
            end
            parts = strsplit(txt, parser);
            
            if nargin > 3 && fromEnd
                inds = unique(max(1, fliplr(length(parts) - inds +1)));
            end
            
            if max(inds) <= length(parts)
                out = join(parts(inds), parser);
            else
                out = join(parts, parser);
            end
        end
    end
    
    %% Convert to String
    methods (Static)
        function strred = type2str(val)
            if ~ismissing(val)
                strred = string(val);
            elseif isnumeric(val)
                strred = "NaN";
            elseif iscategorical(val)
                strred = "undefined";
            else
                strred = string(val);
            end
        end
    end
    
    %% Extract by Character Type
    methods (Static)
        function nums = num_get(str)
            nums = str2double(regexp(string(str),'\d*','Match'));
            
            if isempty(nums)
                nums = NaN;
            end
        end
        
        function letts = letter_get(str)
            if ~ismissing(str)
                chr = char(str);
                letts = chr(isletter(chr));
                letts = string(letts);
            else
                letts = "";
            end
        end
        
        function out = eraseAny(orig, dels)
            out = string(size(orig));
            for istr = 1:length(orig)
                strC = char(orig(istr));
                for idel = 1:length(dels)
                    delC = char(dels(idel));
                    strC(strC == delC) = [];
                end
                out(istr) = string(strC);
            end
        end
    end
    
    %% Extract by Location
    methods (Static)
        function inside = getInside(text, btwn_chars)
            inside = "";
            for itxt = 1:length(text)
                [chartxt, start_ind, end_ind] = Str.inds_find(text(itxt), btwn_chars);
                inside(itxt) = string(chartxt(start_ind+1 : end_ind-1));
            end
        end
        
        function outside = getOutside(text, btwn_chars)
            outside = Str.eraseBtwn_loop(text, ...
                [btwn_chars(:,1); btwn_chars(:,1)], ...
                [btwn_chars(:,2); btwn_chars(:,2)], 'inclusive');
        end
    end
    
    methods (Static, Access = private)
        function [text, start_ind, end_ind] = inds_find(text, btwn_chars)
            text = char(text);
            start_ind = find(Str.get_ind(text, btwn_chars{1}));
            end_ind = find(Str.get_ind(text, btwn_chars{2}));
        end
        function ind = get_ind(text, reqChar)
            ind = text == reqChar;
            assert(sum(ind) <= 1, "Character appears more than once");
        end
    end
    
    methods (Static)
        function str = eraseBtwn_loop(str, startStr, endStr, boundaries)
            %eraseBetween for multiple startStr and endStr pairs
            assert(all(size(startStr) == size(endStr)))
            
            for irmv = 1:length(startStr)
                str = eraseBetween(str, startStr(irmv), endStr(irmv), ...
                    'Boundaries', boundaries);
            end
        end
    end
end