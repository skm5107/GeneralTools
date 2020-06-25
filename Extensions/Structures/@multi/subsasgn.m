function self = subsasgn(self, requests, new)
    [propName, requests] = self.reference(requests);
    new = prepNew(requests(end), new);
    self.(propName) = subsasgn(self.(propName), requests, new);
end

function new = prepNew(req, new)
    if req.type == "()"
        new = Arr.cellify(new, 1);
    end
    
    reqLen = length([req.subs{:}]);
    if length(new) == 1 && reqLen > 1
        new = repmat(new, [1, reqLen]);
    end
end