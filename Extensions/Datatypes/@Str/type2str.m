function strred = type2str(val)
    if ~ismissing(val)
        strred = string(val);
    elseif isnumeric(val)
        strred = "NaN";
    elseif iscategorical(val)
        strred = "undefined";
    else
        strred = string(val);
    end
end