function inside = getInside(text, btwnChars)
    inside = "";
    for itxt = 1:length(text)
        [chartxt, start_ind, end_ind] = Str.inds_find(text(itxt), btwnChars);
        inside(itxt) = string(chartxt(start_ind+1 : end_ind-1));
    end
end