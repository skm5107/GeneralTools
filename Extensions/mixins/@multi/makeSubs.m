function req = makeSubs(self, req)
    [isNum, ind] = cellfun(@checkNumeric, Arr.cellify(req.subs));
    if ~isNum
        reqtypes = preProc_types(req);
        ind = cellfun(@(jtype) ismatch(jtype, reqtypes), self.types);
    end
    req = postProc_reqs(req, ind);
end

function [tf, sub] = checkNumeric(sub)
    if islogical(sub)
        sub = find(sub);
    end
    isNumber = isnumeric(sub);
    isAll = isequaln(sub, ":");
    tf = all(isNumber| isAll);
end

function reqtypes = preProc_types(req)
    if ischar(req.subs)
        reqtypes = {req.subs};
    elseif ~iscell(req.subs{:})
        reqtypes = num2cell(req.subs{:});
    else
        reqtypes = req.subs;
    end
end

function req = postProc_reqs(req, ind)
    if req.type == "."
        req.type = '{}';
    end
    req.subs = {find(ind)};
end

function tf = ismatch(selftypes, reqtypes)
    selftypes = Arr.cellify(selftypes);
    tf = cellfun(@(jtype) any(Log.anyequaln(jtype, reqtypes)), selftypes);
    tf = any(tf);
end