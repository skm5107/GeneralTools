function converted = castMissing(value)
    if isequal(value, "missing") || isequal(value, "undefined")
        converted = Obj.cast(missing, class(value));
    else
        converted = value;
    end
end