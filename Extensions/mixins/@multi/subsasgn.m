function self = subsasgn(self, request, new)
    [tfStruct, structFld] = self.checkAsStruct(request(1));
    if tfStruct
        self.(structFld) = treatAsStruct(self.(structFld), request(end), new);
    else
        [checkType, new] = preProc_cells(request, new);
        ind = self.getSubs(request, checkType);
        self.values = subsasgn(self.values, ind, new);
    end
end

function fld = treatAsStruct(fld, request, new)
    if ischar(request.subs) && length(fld) <= 1
        fld = Arr.cellify(new);
    else
        fld = subsasgn(fld, request, Arr.cellify(new));
    end
end

function [checkType, new] = preProc_cells(request, new)
    checkType = Arr.uncell(request.subs);
    new = Arr.cellify(new);
end