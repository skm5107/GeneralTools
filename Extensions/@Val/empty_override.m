function varargout = empty_override(current, defaults)
    overridden = current;
    for iarg = 1:length(current)
        if isempty(current{iarg})
            overridden{iarg} = defaults{iarg};
        end
    end
    [varargout{1:nargout}] = overridden{:};
end