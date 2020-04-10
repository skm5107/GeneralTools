function fcnHndl = findFcn(typeSpec)
    hgt = 1:size(Frmt.key, 1);
    matchInd = cellfun(@(iid) compare(Frmt.key.typeID{iid}, typeSpec), num2cell(hgt));
    assert(sum(matchInd) == 1, "Frmt:typeID", "invalid typeSpec character")
    fcnHndl = Frmt.key.fcnHndl{matchInd};
end

function isMatch = compare(itype, typeSpec)
    isMatch = any(ismember(itype, typeSpec));
end