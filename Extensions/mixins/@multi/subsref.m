function varargout = subsref(self, requests)
    [propName, requests] = self.reference(requests);
    varargout = {subsref(self.(propName), requests)};
%     varargout = Arr.flatten(varargout, "horz");
    
    if ~isempty(varargout)
        Warn.warnIf(length(varargout) ~= max(1, nargout), "multi:deal", "multi not capturing all varargout matches")
    else
        varargout{1} = cell.empty(1,0);
    end    
end