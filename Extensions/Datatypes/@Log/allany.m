function [matches, ismatch] = allany(matchAlls, options)
    ismatch = cellfun(@(ilist) checkRules(ilist, options), matchAlls);
    matches = matchAlls(ismatch);
end

function checker = checkRules(ilist, options)
    checker = cellfun(@(iopts) checkSingle(ilist, iopts), options);
    checker = all(checker, 'all');
end

function checker = checkSingle(ilist, iopts)
    checker = any(ismember(ilist, iopts), 'all');
end