function [val, arg2] = cat(raw, ~)
    if ~all(ismissing(raw))
        val = categorical(cellstr(raw));
    else
        val = categorical(raw);
    end
    arg2 = missing;
end
