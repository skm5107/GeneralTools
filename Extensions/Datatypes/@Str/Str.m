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

        len = length(strs)
        joined = join(strs, joiner, delNaN)
        splits = strsplit(strs, delimiter)
        out = splitJoin(txt, parser, inds, fromEnd)
        
        out = eraseAny(orig, dels)
        str = eraseBtwn(str, startStr, endStr, boundaries)
        [str, tf] = eraseStart(str, match)
        
        strred = type2str(val)
        [isMatch, start_inds, nextChars] = findNextChar(txt, patterns)
        nums = getNums(str)
        letts = getLetts(str)
        
        inside = getInside(text, btwn_chars)
        outside = getOutside(text, btwn_chars)
        
        function capped = titleCase(text)
            delim = " ";
            parsed = split(text, delim);
            capped = "";
            for jword = parsed'
                jchar = char(jword);
                jupper = upper(jchar(1));
                if length(jchar) > 1
                    jupper = strcat(jupper, jchar(2:end), "");
                end
                capped = capped + delim + jupper;
            end
            capped = strip(capped, delim);
        end
    end
    
    methods (Static, Access = private)
        tf = strloop(strVect, str, hndl)
        [text, start_ind, end_ind] = inds_find(text, btwn_chars)
        ind = get_ind(text, reqChar)
    end        
end