function out = splitJoin(txt, parser, inds, fromEnd)
    if isempty(txt)
        txt = "";
    end
    parts = strsplit(txt, parser);
    
    if nargin > 3 && fromEnd
        inds = unique(max(1, fliplr(length(parts) - inds +1)));
    end
    
    if max(inds) <= length(parts)
        out = join(parts(inds), parser);
    else
        out = join(parts, parser);
    end
end