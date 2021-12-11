function shorter = eraseUpto(str, match)
    charred = char(str);
    istart = strfind(charred, match);
    iend = istart + Str.length(match);
    shorter = charred(iend+1:end);
    if isstring(str)
        shorter = string(shorter);
    end
end