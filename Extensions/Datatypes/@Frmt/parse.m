function val = parse(raw, parseChar)
    clean = strip(raw);
    if ~isempty(parseChar) && parseChar ~= ""
        clean = strip(clean, parseChar);
    end
    val = strip(strsplit(clean, parseChar));
end