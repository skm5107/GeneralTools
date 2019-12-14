function id = verifyIsMember(self, allowableSet)
    self.id = "IsMember";
    if ~self.doThrow, id = self.id; return, end
    
    self.msg = sprintf("variable %s must match 1 of [%s]", self.testVal, join(allowableSet, ", "));
    self.isErr = ~all(ismember(self.testVal, allowableSet));
    id = self.throw_check();
end