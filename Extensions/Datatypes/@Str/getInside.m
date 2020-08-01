function inside = getInside(text, btwn_chars)
    inside = "";
    for itxt = 1:length(text)
        [chartxt, start_ind, end_ind] = Str.inds_find(text(itxt), btwn_chars);
        inside(itxt) = string(chartxt(start_ind+1 : end_ind-1));
    end
end