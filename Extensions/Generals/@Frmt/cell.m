function [val, arg2] = cell(raw, ~)
    val = num2cell(raw);
    arg2 = missing;
end
