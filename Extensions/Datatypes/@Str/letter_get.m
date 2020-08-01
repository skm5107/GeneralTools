function letts = letter_get(str)
    if ~ismissing(str)
        chr = char(str);
        letts = chr(isletter(chr));
        letts = string(letts);
    else
        letts = "";
    end
end