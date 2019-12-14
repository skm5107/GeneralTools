function [reqVals, reqRows, reqRaw] = lookup(key, checkVal, checkVars, reqVars)
    checkCols = checkCols_get(key.Properties.VariableNames, string(checkVars));
    if ~any(checkCols)
        reqVals = table.empty(0, length(string(reqVars)));
        return
    end    
    reqRows = matchingRows_find(key, checkCols, checkVal);
    
    if nargin < 4 || isempty(string(reqVars))
        reqVals = key(reqRows, :);
    else
        reqCols = checkCols_get(key.Properties.VariableNames, string(reqVars));
        reqVals = key(reqRows, reqCols);
    end
    
    if nargout > 2
        reqRaw = reqVals{:,:};
    end
end

function checkCols = checkCols_get(varNames, wantVars)
    wantVars = string(wantVars);
    wantVars = reshape(wantVars, [length(wantVars), 1]);
    checkCols = any(varNames == wantVars, 1);
    if ~any(checkCols)
        warning("Requested variable does not exist in table.")
    end
end

function reqRows = matchingRows_find(key, checkCols, checkVal)
    checkKey = cell_convert(key{:, checkCols});
    checkVal = string(checkVal);
    
    if isempty(checkVal)
        isInRow = cellfun(@(elem) any(ismissing(elem)), checkKey);
    else
        isInRow = cellfun(@(elem) all(ismember(checkVal, string(elem))), checkKey);
    end
    reqRows = any(isInRow, 2);
end

function out = cell_convert(input)
    switch string(class(input))
        case "double"
            out = num2cell(input);
        case "string"
            out = cellstr(input);
        case "categorical"
            out = cellstr(input);
        otherwise
            out = input;
    end
end
