function ref = getSubs(self, req, checkType)
    if all(isnumeric(checkType)) || (all(Str.ischar(checkType)) && all(checkType == ":"))
        ref = req(1:end);
    else
        reqtypes = getReqTypes(req);
        ind = cellfun(@(jtype) ismatch(jtype, reqtypes), self.types);
        ref.type = '()';
        ref.subs = {find(ind)};
    end
end

function reqtypes = getReqTypes(req)
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