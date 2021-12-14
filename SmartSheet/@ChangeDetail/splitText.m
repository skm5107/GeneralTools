function self = splitText(self, splits)
    ntry = 1;
    keepTry = true;
    [remainder, details] = splitNext(self.remainder, splits.exp);
    
    while remainder ~= "" && ~isempty(splits.details(ntry)) && keepTry && ntry <= splits.maxTries
        ntry = ntry + 1;
        [remainder, newDetail, keepTry] = splitNext(remainder, splits.exp, keepTry);
        details = [details, newDetail];
    end
    
    self.details = details;
    self.remainder = remainder;
end

function [remainder, detail, keepTry] = splitNext(rem, exp, keepTry)
    [detail, endInd] = regexp(rem, exp.mid, 'tokens', 'end');
    if ~isempty(endInd)
        remainder = strtrim(extractAfter(rem, endInd(1)));
    else
        detail = regexp(rem, exp.end, 'tokens');
        remainder = checkDetail(detail, rem);
        keepTry = false;
    end
end

function remainder = checkDetail(detail, rem)
    if ~isempty(detail)
        remainder = "";
    else
        warning("ChangeDetail:split:undetectable", "Could not find detail in %s", rem);
        remainder = rem;
    end
end