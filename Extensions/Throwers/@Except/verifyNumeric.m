function id = verifyNumeric(self)
    self.id = "RequiresNumeric";
    if ~self.doThrow, id = self.id; return, end
    
    self.msg = sprintf("requires a numeric value");
    self.isErr = ~isnumeric(self.testVal);
    id = self.throw_check();
end