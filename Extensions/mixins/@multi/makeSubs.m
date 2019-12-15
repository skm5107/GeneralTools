function req = makeSubs(self, req)
    isNum = cellfun(@checkNumeric, Arr.cellify(req.subs));
    if ~isNum
        reqtypes = preProc_reqs(req);
        ind = cellfun(@(jtype) ismatch(jtype, reqtypes), self.types);
        req.subs = {find(ind)};
    end
end

function tf = checkNumeric(sub)
    isNumber = isnumeric(sub);
    isAll = isequaln(sub, ":");
    tf = all(isNumber| isAll);
end

function reqtypes = preProc_reqs(req)
    if ischar(req.subs)
        reqtypes = {req.subs};
    elseif ~iscell(req.subs{:})
        reqtypes = num2cell(req.subs{:});
    else
        reqtypes = req.subs;
    end
end

function tf = ismatch(selftypes, reqtypes)
    selftypes = Arr.cellify(selftypes);
    tf = cellfun(@(jtype) any(Log.anyequaln(jtype, reqtypes)), selftypes);
    tf = any(tf);
end