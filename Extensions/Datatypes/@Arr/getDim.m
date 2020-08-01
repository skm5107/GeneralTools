function [dim, val] = getDim(input, minORmax)
    sz = size(input);
    if minORmax == "min"
        [val, dim] = min(sz);
    elseif minORmax == "max"
        [val, dim] = max(sz);
    else
        assert(false, "Select min or max dimension")
    end
end