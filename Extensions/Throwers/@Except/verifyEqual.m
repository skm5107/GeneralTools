function id = verifyEqual(self, reqVal, location)
    self.id = "MustEqual";
    if ~self.doThrow, id = self.id; return, end
    
    self.msg = Prnt.sprintf("%s must equal %s in %s", self.testVal, reqVal, location);
    self.isErr = self.testVal ~= reqVal;
    id = self.throw_check();
end