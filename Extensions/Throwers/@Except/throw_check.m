function id = throw_check(self)
    if self.isErr && self.doThrow
        self.throwErr;
    else
        id = self.id;
    end
end