function throwErr(self)
    errMsg = sprintf("%s %s", reqFcn_trace, self.msg);
    fullID = fullID_make(self.id);
    err = MException(fullID, errMsg);
    throw(err);
end

function fullID = fullID_make(self, id)
    fullID = sprintf("%s:%s", self.component, id);
end

function reqFcn = reqFcn_trace(~)
    stack = dbstack;
    tracename = stack(end).name;
    shortnames = strrep(char(tracename), {'get.', 'set.'}, '');
    [~, shorterInd] = min(cellfun(@length, shortnames));
    reqFcn = string(shortnames(shorterInd));
end
end