function len = length(str)
    len = cellfun(@getlen, Arr.cellify(str));
end

function len = getlen(jstr)
    aschar = char(jstr);
    len = length(aschar);
end