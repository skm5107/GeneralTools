function varargout = subsref(self, requests)
    [propName, requests] = self.reference(requests);
    [requests, isCell] = square2paren(requests);
    
    varargout = subsref(self.(propName), requests);
    varargout = {reshape(varargout, 1, [])}; %address underlying transpose issue
    varargout = recell(varargout, isCell);
    
    if ~isempty(varargout)
        Warn.warnIf(length(varargout) > max(1, nargout), "multi:deal", "multi not capturing all varargout matches")
    else
        varargout{1} = cell.empty(1,0);
    end
end

function [requests, isCell] = square2paren(requests)
    if requests.type == "{}"
        requests.type = "()";
        isCell = true;
    else
        isCell = false;
    end
end

function outs = recell(outs, isCell)
    if isCell
        outs = outs{:};
    end
end