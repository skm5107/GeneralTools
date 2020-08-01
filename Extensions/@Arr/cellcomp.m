function [isSame, diff] = cellcomp(orig, new, tolPos, tolNeg)
    assert(ndims(orig) == ndims(new) && all(size(orig) == size(new)), "Arr:size", "size(arg1) == size(arg2)")
    
    if nargin < 3
        tolPos = num2cell(nan(size(orig)));
    end
    if nargin < 4
        tolNeg = cellfun(@Num.makeNeg, tolPos, 'uni', 0);
    end
    [isSame, diff] = cellfun(@compSingle, orig, new, tolPos, tolNeg);
end

function [isame, idiff] = compSingle(iorig, inew, ipos, ineg)
    if isnumeric(iorig) && isnumeric(inew)
        [isame, idiff] = checkTol(iorig, inew, ipos, ineg);
    else
        isame = isequaln(iorig, inew);
        idiff = NaN;
    end
end

function [isame, idiff] = checkTol(iorig, inew, ipos, ineg)
    idiff = inew - iorig;
    isame = idiff <= ipos && idiff >= ineg;
end