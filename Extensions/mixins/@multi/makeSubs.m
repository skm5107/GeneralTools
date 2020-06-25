function request = makeSubs(self, request)
    request = log2num(request);    
    [isNum, ind] = cellfun(@checkNumeric, Arr.cellify(Arr.uncell(request.subs)));
    if ~isNum
        reqlabels = preProc_labels(request);
        ind = cellfun(@(jlabel) ismatch(jlabel, reqlabels), self.labels);
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

function reqlabels = preProc_labels(req)
    if ischar(req.subs)
        reqlabels = {req.subs};
    elseif ~iscell(req.subs{:})
        reqlabels = num2cell(req.subs{:});
    else
        reqlabels = req.subs;
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

function tf = ismatch(selflabels, reqlabels)
    selflabels = Arr.cellify(selflabels);
    tf = cellfun(@(jlabel) any(Log.anyequaln(jlabel, reqlabels)), selflabels);
    tf = any(tf);
end