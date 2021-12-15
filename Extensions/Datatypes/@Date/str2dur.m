function dur = str2dur(str)
    if ismissing(str)
        dur = NaT-NaT;
    elseif str == "0"
        dur = days(0);
    elseif contains(str, "d")
        dur = days(Str.getNums(str));
    elseif contains(str, "w")
        dur = days(Str.getNums(str))*7;
    else
        error("Unknown duration text: %s", str);
    end
end