function [val, arg2] = num(raw, ~)
    val = double(string(raw));
    arg2 = missing;
end