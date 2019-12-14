function varargout = subsref(self, request)
    [tfStruct, structFld] = self.checkAsStruct(request(1));
    [reqInd, checkType] = preProc_brackets(request(end));
    
    if tfStruct
        varargout = treatAsStruct(self.(structFld), reqInd);
    else
        ind = self.getSubs(reqInd, checkType);
        varargout = subsref(self.values, ind);
    end
    
    if ~isempty(varargout)
        varargout = postProc_brackets(varargout, request(end), tfStruct);
        Warn.warnIf(length(varargout) ~= max(1, nargout), "multi:deal", "multi not capturing all varargout matches")
    else
        varargout{1} = cell.empty(1,0);
    end
end

function out = treatAsStruct(fld, reqInd)
    if ischar(reqInd.subs)
        out = fld;
    else
        out = subsref(fld, reqInd);
    end
end

function [reqInd, checkType] = preProc_brackets(reqInd)
    if reqInd.type == "{}"
        reqInd.type = '()';
    end
    checkType = Arr.uncell(reqInd.subs);
end

function var = postProc_brackets(var, request, tfStruct)
    if request(1).type == "()" || (tfStruct && request(1).type ~= "{}")
        var = {var};
    end
end