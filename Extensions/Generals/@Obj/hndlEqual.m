function isEqual = hndlEqual(ObjA, ObjB, props)
    if nargin < 3
        props = properties(ObjA)';
    end
    
    if size(ObjA) ~= size(ObjB)
        isEqual = false;
    elseif all(class(ObjA) ~= class(ObjB))
        isEqual = false;
    else
        propsEqual = cellfun(@(jprop) Val.isEqual(ObjA.(jprop), ObjB.(jprop)), props);
        isEqual = all(Arr.uncell(propsEqual));
    end
end