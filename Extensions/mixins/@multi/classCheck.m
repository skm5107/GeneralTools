function out = classCheck(multiORvals, reqClass, tfConvert)
    if nargin < 3
        tfConvert = true;
    end
    [vals, isMulti] = preproc_class(multiORvals);
    
    changed = cellfun(@(jin) doSingle(jin, reqClass, tfConvert), vals, 'uni', false);
    if isMulti
        out = multiORvals;
        out.values = changed;
    else
        out = multi(changed);
    end
end

function [vals, isMulti] = preproc_class(multiORvals)
    isMulti = ismember("multi", Obj.allclasses(multiORvals));
    if isMulti
        vals = multiORvals.values;
    else
        vals = Arr.cellify(multiORvals);
    end
end

function out = doSingle(vals, reqClass, tryConvert)
    if ismember(reqClass, Obj.allclasses(vals))
        out = vals;
    elseif tryConvert
        hndl = str2func(reqClass);
        out = hndl(vals);
    else
        assert(false, "multi:Class", "Input is not of class: %s", reqClass);
    end
end