function [str, tf] = eraseStart(str, match)
    if startsWith(str, match)
        len = Str.length(match);
        str = multicall(str, len);
        tf = true;
    else
        tf = false;
    end
end

function str = multicall(str, len)
    if class(str) == "string"
        str = cellstr(str);
        reconvert = true;
    else
        reconvert = false;
    end
    
    str = cellfun(@(istr) deleter(istr, len), str, 'uni', 0);
    
    if reconvert
        str = string(str);
    end
end

function istr = deleter(istr, len)
    istr(1:len) = [];
end