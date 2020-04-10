function [val, arg2] = log(raw, ~)
    num = Frmt.num(raw);
    if num == 1
        val = true;
    else
        val = false;
    end
    arg2 = missing;
end
