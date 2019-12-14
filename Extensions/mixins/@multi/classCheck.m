function out = classCheck(input, reqClass, tfConvert)
    if nargin < 3
        tfConvert = true;
    end
    
    incell = Arr.cellify(input);
    out = cellfun(@(jin) doSingle(jin, reqClass, tfConvert), incell, 'uni', false);

    if ismember("multi", Obj.allclasses(input))
        out = [out{:}];
    end
end

function out = doSingle(input, reqClass, tryConvert)
    if ismember(reqClass, Obj.allclasses(input))
        out = input;
    elseif ismember("multi", Obj.allclasses(input)) && ismember(reqClass, Obj.allclasses(input.get))
        out = input;
    elseif tryConvert
        hndl = str2func(reqClass);
        out = hndl(input);
    else
        assert(false, "multi:Class", "Input is not of class: %s", reqClass);
    end
end