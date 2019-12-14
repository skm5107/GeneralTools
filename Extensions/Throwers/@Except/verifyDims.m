function id = verifyDims(self, reqSz)
    self.id = "IsSize";
    if ~self.doThrow, id = self.id; return, end
    
    self.msg = sprintf("variable of size [%s] must be of size [%s]", ...
        Prnt.vectprintf(size(self.testVal)), Prnt.vectprintf(reqSz));
    
    testSz = size(self.testVal);
    if ~all(size(testSz) == size(reqSz))
        self.isErr = true;
    else
        dimsToCheck = isfinite(reqSz);
        self.isErr = ~all(testSz(dimsToCheck) == reqSz(dimsToCheck));
    end
    id = self.throw_check();
end