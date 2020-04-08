function outside = getOutside(txt, btwn_chars)
    if ismissing(txt)
        outside = "";
    else
        outside = cellfun(@(jtxt) doSingle(jtxt, string(btwn_chars)), txt, 'uni', false);
    end
    outside = string(outside);
end

function outside = doSingle(txt, btwn_chars)
    outside = Str.eraseBtwn(txt, ...
        [btwn_chars(:,1); btwn_chars(:,1)], ...
        [btwn_chars(:,2); btwn_chars(:,2)], 'inclusive');
end