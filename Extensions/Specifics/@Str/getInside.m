function inside = getInside(txt, btwn_chars)
    if ismissing(txt)
        inside = "";
    else
        inside = cellfun(@(itxt) doSingle(itxt, btwn_chars), txt);
    end
end

function inside = doSingle(txt, btwn_chars)
    [charTxt, start_ind, end_ind] = Str.inds_find(txt, btwn_chars);
    inside = string(charTxt(start_ind+1 : end_ind-1));
end