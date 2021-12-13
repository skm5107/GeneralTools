function [val, arg2] = hndl(raw, ~)
    val = str2func(raw);
    arg2 = missing;
end