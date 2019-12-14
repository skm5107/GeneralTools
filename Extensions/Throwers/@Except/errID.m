function fullID = errID(checkName)
    self = Except;
    self.doThrow = false;
    method_hndl = str2func(checkName);
    id = method_hndl(self);
    fullID = self.fullID_make(id);
end