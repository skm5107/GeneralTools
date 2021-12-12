function self = splitDetails(self, splits)
    ntry = 1;
    [splits.details(ntry), remainder] = splitNext(self.remainder, splits.exp);
    
    while remainder ~= "" && ~isempty(splits.details(ntry)) && ntry <= splits.maxTries
        ntry = ntry + 1;
        [splits.details(ntry), remainder] = splitNext(remainder, splits.exp);
    end
    
    self.details = splits.details(~cellfun(@isempty, splits.details));
    self.remainder = remainder;
end

function [detail, remainder] = splitNext(remainder, exp)
    [detail, endInd] = regexp(remainder, exp.mid, 'tokens', 'end');
    if ~isempty(endInd)
        remainder = strtrim(extractAfter(remainder, endInd));
    else
        detail = regexp(remainder, exp.end, 'tokens');
        remainder = "";
    end
end