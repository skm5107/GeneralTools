function val_out = to(val_in, unit2unit)
    [val_in, origShape] = Arr.flatten(val_in, "horz");
    [unit_in, unit_out] = units_parse(unit2unit);
    
    val_out = tryDirectConvert(val_in, [unit_in, unit_out]);
    if ~isempty(val_out)
        val_out = reshape(val_out, origShape);
        return
    end

    [base_in, base_out, presuff_mult] = Convert.presuffix_parse(unit_in, unit_out);
    if base_in == base_out
        val_out = reshape(val_in * presuff_mult, origShape);
        return
    end
    
    val_out = tryDirectConvert(val_in, [base_in, base_out]);
    if ~isempty(val_out)
        val_out = reshape(val_out * presuff_mult, origShape);
        return
    end
    
    val_out = Convert.iterativeConvert(val_in, base_in, base_out);
    if ~isempty(val_out)
        val_out = reshape(val_out * presuff_mult, origShape);
        return
    end    
    
    
    if ~isempty(val_out)
        val_out = reshape(val_out * presuff_mult, origShape);
    else
        error("Unit:Convert", "Cannot convert %g from %s to %s", val_in, unit_in, unit_out);
    end
end

function [unit_in, unit_out] = units_parse(unit2unit)
    parsed = split(unit2unit, Convert.unit2unit_div);
    unit_in = categorical(parsed(1));
    unit_out = categorical(parsed(2));
end

function val_out = tryDirectConvert(val_in, unitsInOut)
    key_row = all([Convert.key.unitA, Convert.key.unitB] == unitsInOut, 2);
    val_out = val_in .* Convert.key.AtoB_mult(key_row);
    if ~isempty(val_out) && all(isnan(val_out)) && ~all(isnan(val_in))
        val_out = fcnConvert(val_in, Convert.key.fcnHndl(key_row));
    end
end

function val_out = fcnConvert(val_in, fcnHndl)
    fcnHndl = Val.delmissing(fcnHndl);
    fcnHndl = str2func(Convert.keyFcnHndlClass + "." + fcnHndl);
    val_out = fcnHndl(val_in);
end