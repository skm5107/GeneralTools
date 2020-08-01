function val = firstNotEmpty_select(varargin)
    shouldAgree = {};
    for iarg = varargin
        if ~isempty(iarg{:}) && ~ismissing(iarg{:})
            shouldAgree = [shouldAgree, iarg];
        end
    end
    
    if length(shouldAgree) > 1
        valsAgree = isequal(shouldAgree{:});
        if ~valsAgree
            warning("Two or more values non-empty and not equal.")
        end
    end
    
    val = shouldAgree{1};
end