function fcnHndl = proto2id(proto)
    hgt = 1:size(Frmt.key, 1);
    matchInd = cellfun(@(icheck) check(Frmt.key.convertHndl{icheck}, proto), num2cell(hgt));
    assert(sum(matchInd) == 1, "Frmt:convert", "unknown datatype for Frmt.key")
    fcnHndl = Frmt.key.convertHndl{matchInd};
end

function isMatch = check(ihndl, proto)
    isMatch = ihndl(proto);
end