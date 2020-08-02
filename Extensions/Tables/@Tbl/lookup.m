function reqTbl = lookup(tbl, matchVal, matchCol, reqCol)
    if nargin < 4
        reqCol = 1:width(tbl);
    end
    
    hgt = 1:size(tbl, 1);
    matchInd = cellfun(@(irow) check(tbl.(matchCol){irow}, matchVal), num2cell(hgt));
    reqTbl = tbl(matchInd, reqCol);
end

function isMatch = check(irow, val)
    if ischar(irow)
        irow = string(irow);
    end
    if ischar(val)
        val = string(val);
    end
    isMatch = any(ismember(irow, val));
end