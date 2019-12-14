function id = verifyClass(self, classOptions)
    self.id = "CorrectClass";
    if ~self.doThrow, id = self.id; return, end
    
    self.msg = sprintf("variable %s must be of class [%s]", self.testVal_name, join(classOptions, ", "));
    self.isErr = ~any(ismember(Obj.allclasses(self.testVal), classOptions(:)));
    id = self.throw_check();
end