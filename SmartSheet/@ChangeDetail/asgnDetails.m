function self = asgnDetails(self, parses, key)
    for jdetail = self.details
        jdet = jdetail{1};
        jtype = jdet(parses.typeInd);
        jind = (key.smartsheet == jtype);
        jcol = key.tblVar(jind);
        if jcol ~= ""
            [parses.old.(jcol), parses.new.(jcol)] = parseNext(jdet, jind, parses, key);
        end
    end
    self.old = parses.old;
    self.new = parses.new;
end

function [jold, jnew] = parseNext(detail, jind, parses, key)
    jhndl = str2func(key.hndl{jind});
    jold = detail(parses.oldInd);
    try 
        jold = jhndl(jold);
    catch
        jold = jhndl(missing);
    end
    
    jnew = detail(parses.newInd);
    try
        jnew = jhndl(jnew);
    catch
        jnew = jhndl(missing);
    end
end