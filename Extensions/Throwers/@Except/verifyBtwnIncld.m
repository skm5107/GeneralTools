function id = verifyBtwnIncld(self, reqVals, location)
    self.id = "MustBeBetween";
    if ~self.doThrow, id = self.id; return, end
    
    self.msg = Prnt.sprintf("%s must be between %s and %s in %s", self.testVal, min(reqVals), max(reqVals), location);
    self.isErr = ~((self.testVal >= min(reqVals)) && (self.testVal <= max(reqVals)));
    id = self.throw_check();
end