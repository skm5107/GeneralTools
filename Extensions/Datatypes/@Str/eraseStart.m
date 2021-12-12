function [str, tf] = eraseStart(str, match)
    if startsWith(str, match)
        len = strlength(match);
        str = extractAfter(str, len);
        tf = true;
    else
        tf = false;
    end
end