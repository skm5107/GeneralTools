function [tfStruct, structFld] = checkAsStruct(self, request)
    if ischar(request.subs)
        tfStruct = ismember(request.subs, fields(self));
    else
        tfStruct = false;
    end
    structFld = request.subs;
end