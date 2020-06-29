function out = propCheck(multiORvals, reqClass, minmaxDims, tfConvert)
    if nargin < 2 || ~Val.isFull(reqClass)
        reqClass = missing;
    end
    if nargin < 3 || ~Val.isFull(reqClass)
       minmaxDims = [0 1];
    end
    if nargin < 4
        tfConvert = true;
    end
    
    isMulti = ismember("multi", Obj.allclasses(multiORvals));
    if isMulti
        out = doMulti(multiORvals, reqClass, minmaxDims, tfConvert);
    else
        out = doVals(multiORvals, reqClass, minmaxDims, tfConvert);
    end
end

function out = doMulti(out, reqClass, minmaxDims, tfConvert)
    out.values = cellfun(@(jin) checkClass(jin, reqClass, tfConvert), out.values, 'uni', 0);
    assert(all(size(out) >= min(minmaxDims)), "input:size", "multi size smaller than minimum dimension");
    assert(all(size(out) <= max(minmaxDims)), "input:size", "multi size larger than maximum dimension");
end

function out = doVals(vals, reqClass, minmaxDims, tfConvert)
    vals = cellfun(@(jin) checkClass(jin, reqClass, tfConvert), Arr.cellify(vals), 'uni', 0);
    if ~isempty(vals)
        out = multi(vals);
    elseif min(minmaxDims) == 0
        out = multi.empty;
    else
        out = multi(missing);
    end
end

function out = checkClass(vals, reqClass, tryConvert)
    if ismissing(reqClass)
        out = vals;
    elseif ismember(reqClass, Obj.allclasses(vals))
        out = vals;
    elseif tryConvert
        hndl = str2func(reqClass);
        out = hndl(vals);
    else
        assert(false, "multi:Class", "Input is not of class: %s", reqClass);
    end
end