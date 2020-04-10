function [val, arg2] = clock(raw, style)
    if nargin < 2
        val = Date.read(string(raw));
    else
        val = Date.read(string(raw), 'InputFormat', style);
    end
    arg2 = missing;
end
