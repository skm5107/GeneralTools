function [val, arg2] = catTF(log, ~)
    val = categorical(strings(size(log)));
    for ind = 1:length(log(:))
        if log(ind)
            val(ind) = categorical("true");
        else
            val(ind) = categorical("false");
        end
        arg2 = missing;
    end
end
