function prop = delExtraMissing(prop)
    prop = Val.delmissing(prop);
    if isempty(prop)
        prop = Cls.cast(missing, class(prop));
    end
end
