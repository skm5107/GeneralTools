function [val, arg2] = clock(raw, style)
    if nargin < 2 || ~Val.isFull(style)
        val = datetime(string(raw));
    else
        val = datetime(string(raw), 'InputFormat', style);
    end
    arg2 = missing;
end