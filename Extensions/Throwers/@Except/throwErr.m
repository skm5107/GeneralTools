function throwErr(self)
    errMsg = sprintf("%s %s", reqFcn_trace, self.msg);
    fullID = self.fullID_make(self.id);
    err = MException(fullID, errMsg);
    throw(err);
end

function reqFcn = reqFcn_trace()
    stack = dbstack;
    tracename = stack(end).name;
    shortnames = strrep(char(tracename), {'get.', 'set.'}, '');
    [~, shorterInd] = min(cellfun(@length, shortnames));
    reqFcn = string(shortnames(shorterInd));
end