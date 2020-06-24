function request = makeSubs(self, request)
    request = log2num(request);    
    [isNum, ind] = cellfun(@checkNumeric, Arr.cellify(Arr.uncell(request.subs)));
    if ~isNum
        reqtypes = preProc_types(request);
        ind = cellfun(@(jtype) ismatch(jtype, reqtypes), self.types);
    end
    
    request = postProc_reqs(request, ind);
end

function request = log2num(request)
    if islogical(Arr.uncell(request.subs))
        request.subs = {find(request.subs{:})};
    end
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
    if islogical(ind)
        req.subs = {find(ind)};
    end
end

function tf = ismatch(selftypes, reqtypes)
    selftypes = Arr.cellify(selftypes);
    tf = cellfun(@(jtype) any(Log.anyequaln(jtype, reqtypes)), selftypes);
    tf = any(tf);
end