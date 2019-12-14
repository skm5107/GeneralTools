function [base_in, base_out, mult] = presuffix_parse(unit_in, unit_out)
    [base_in, mult_in] = getBaseUnit(unit_in);
    [base_out, mult_out] = getBaseUnit(unit_out);
    mult = mult_in / mult_out;
end

function [base, mult] = getBaseUnit(raw)
    [suffix, remainder] = suffix_extract(raw);
    [maybePrefix, maybeBase] = prefix_extract(remainder);
    
    isBase = any(Convert.key.unitA == categorical(maybeBase));
    if ~isempty(maybeBase) && ~isempty(maybePrefix) && isBase
        [~, ~, preMult] = Key.lookup(Convert.preKey, maybePrefix, "prefix", "mult");
        base = categorical(maybeBase);
    else
        preMult = 1;
        base = categorical(raw);
    end
    
    if ~isnan(suffix)
        mult = preMult ^ suffix;
    else
        mult = preMult;
    end 
end

function [prefix, remainder] = prefix_extract(raw)
    prefix = regexp(raw, "^[" + Convert.preExpr + "]", "match");
    remainder = regexp(raw, "^[" + Convert.preExpr + "]", "split");
    remainder = Val.delmissing(remainder);
end

function [suffix, base] = suffix_extract(remainder)
    suffix = Str.getNums(remainder);
    base = Str.getLetts(remainder);
end