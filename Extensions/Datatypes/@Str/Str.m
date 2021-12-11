classdef Str
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
        
        [ind, match_frac] = closestMatch(strVect, str)
        dist = lev(str1, str2)

        joined = join(strs, joiner, delNaN)
        splits = strsplit(strs, delimiter)
        out = splitJoin(txt, parser, inds, fromEnd)
        
        out = eraseAny(orig, dels)
        str = eraseBtwn(str, startStr, endStr, boundaries)
        [str, tf] = eraseStart(str, match)
        shorter = eraseUpto(str, match)
        
        
        strred = type2str(val)
        [isMatch, start_inds, nextChars] = findNextChar(txt, patterns)
        nums = getNums(str)
        letts = getLetts(str)
        
        inside = getInside(text, btwn_chars)
        outside = getOutside(text, btwn_chars)
        capped = titleCase(text)
    end
    
    methods (Static, Access = private)
        tf = strloop(strVect, str, hndl)
        [text, start_ind, end_ind] = inds_find(text, btwn_chars)
        ind = get_ind(text, reqChar)
    end        
end