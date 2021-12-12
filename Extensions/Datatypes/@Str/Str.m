classdef Str
    methods (Static)        
        tf = loop(str, patVect, hndl)
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
        [text, start_ind, end_ind] = inds_find(text, btwn_chars)
        ind = get_ind(text, reqChar)
    end        
end