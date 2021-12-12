function self = splitDetails(self)
    details = ChangeDetail.const.detailsEmpty;
    detExp = ChangeDetail.const.detExp;
    maxTries = ChangeDetail.const.maxTries;
    ntry = 1;
    
    [newDetail, remainder] = getNext(self.remainder, detExp);
    details(ntry) = newDetail;
    ntry = ntry + 1;
    
    while remainder ~= "" && ~isempty(newDetail) && ntry <= maxTries
        [newDetail, remainder] = getNext(remainder, detExp);
        details(ntry) = newDetail;
        ntry = ntry + 1;
    end
    
    self.details = details;
    self.remainder = remainder;
end

function [detail, remainder] = getNext(remainder, detExp)
    [detail, endInd] = regexp(remainder, detExp, 'match', 'end');
    if ~isempty(endInd)
        remainder = strtrim(extractAfter(remainder, endInd));
    else
        detail = remainder;
        remainder = "";
    end
end