function id = verifyFileOpens(self)
            self.id = "OpenableFile";
            if ~self.doThrow, id = self.id; return, end %%TODO: better way
            
            self.msg = sprintf("cannot open file %s", Prnt.path(self.testVal));
            fhndl = fopen(self.testVal);
            self.isErr = fhndl == -1;
            if ~self.isErr
                fclose(fhndl);
            end
            id = self.throw_check();
        end
        