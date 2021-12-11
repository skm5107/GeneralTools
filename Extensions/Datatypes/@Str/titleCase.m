function capped = titleCase(text)
    delim = " ";
    parsed = split(text, delim);
    capped = "";
    for jword = parsed'
        jchar = char(jword);
        jupper = upper(jchar(1));
        if length(jchar) > 1
            jupper = strcat(jupper, jchar(2:end), "");
        end
        capped = capped + delim + jupper;
    end
    capped = strip(capped, delim);
end