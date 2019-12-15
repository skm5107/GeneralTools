function self = subsasgn(self, requests, new)
    [propName, requests] = reference(self, requests);
    self.(propName) = subsasgn(self.(propName), requests, new);
end