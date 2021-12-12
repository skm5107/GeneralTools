function self = asgnDetails(self, parses)
    for jdetail = self.details'
        jdet = jdetail{1};
        jtype = jdet(parses.typeInd);
        jcol = parses.varNames(parses.types == jtype);
        if jcol ~= ""
            [parses.old.(jcol), parses.new.(jcol)] = parseNext(jdet, parses);
        end
    end
    self.old = parses.old;
    self.new = parses.new;
end

function [jold, jnew] = parseNext(detail, parses)
    jold = detail(parses.oldInd);
    jnew = detail(parses.newInd);
end