function self = splitDetails(self, splits)
    ntry = 1;
    [remainder, details] = splitNext(self.remainder, splits.exp);
    
    while remainder ~= "" && ~isempty(splits.details(ntry)) && ntry <= splits.maxTries
        ntry = ntry + 1;
        [remainder, newDetail] = splitNext(remainder, splits.exp);
        details = [details, newDetail];
    end
    
    %self.details = splits.details(~cellfun(@isempty, splits.details));
    self.details = details;
    self.remainder = remainder;
end

function [remainder, detail] = splitNext(rem, exp)
    [detail, endInd] = regexp(rem, exp.mid, 'tokens', 'end');
    if ~isempty(endInd)
        remainder = strtrim(extractAfter(rem, endInd(1)));
    else
        detail = regexp(rem, exp.end, 'tokens');
        remainder = "";
    end
    assert(~isempty(detail), "ChangeDetail:split:undetectable", "Could not find detail in %s", rem)
end