function id = verifyPositive(self)
    self.id = "RequiresPositive";
    if ~self.doThrow, id = self.id; return, end
    
    self.msg = sprintf("variable %s must be positive", self.testVal_name);
    self.isErr = ~all(self.testVal >= 0);
    id = self.throw_check();
end