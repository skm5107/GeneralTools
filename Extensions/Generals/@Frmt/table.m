function [val, arg2] = table(raw, ~)
    if ~ismissing(raw)
        val = cell2table(raw);
    else
        val = table(missing);
    end
    arg2 = missing;
end
