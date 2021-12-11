function wDecs = addDecimal(num, decGrp, decSep)
    if nargin < 2 || isempty(decGrp)
        decGrp = Frmt.decGrp;
    end
    if nargin < 3 || isempty(decSep)
        decSep = Frmt.decSep;
    end
    
    if isnumeric(num)
        frmt = "%." + string(decGrp) + "f";
        wDecs = sprintf(frmt, num);
    else
        [txt, decInd] = getDecInd(num, decGrp, decSep);
        wDecs = frmtTxt(txt, decInd, decGrp);
    end
    
    wDecs = string(wDecs);
end

function wDecs = frmtTxt(txt, decInd, decGrp)
    extraDigits = length(txt) - (decInd + decGrp);
    if extraDigits == 0
        wDecs = txt(1 : decInd + decGrp);
    elseif extraDigits > 0
        wDecs = roundTxt(txt, decInd, decGrp);
    else
        zz = repmat('0', 1, -extraDigits);
        wDecs = [txt, zz];
    end
end

function [txt, decInd] = getDecInd(num, decGrp, decSep)
    txt = char(string(num));
    decInd = regexpi(txt, "[" + decSep + "]");
    
    errTxt = sprintf("Multiple delimiters: %s (delimiter = %s)", txt, decGrp);
    Warn.warnIf(length(decInd) > 1, "Frmt:Decimal", errTxt);
    
    if isempty(decInd)
        txt = [txt, decSep];
        decInd = length(txt);
    end
end

function wDecs = roundTxt(txt, decInd, decGrp)
    wDecs = txt(1 : decInd + decGrp);
    roundCheck = txt(decInd + decGrp + 1);
    if double(string(roundCheck)) >= 5
        roundDig = double(string(txt(decInd + decGrp))) + 1;
        rounded = char(string(roundDig));
        wDecs(end) = char(string(rounded));
    end
end