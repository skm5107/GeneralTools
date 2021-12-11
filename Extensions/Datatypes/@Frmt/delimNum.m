function frmtted = delimNum(num, numGrp, numSep)
    if nargin < 2 || isempty(numGrp)
        numGrp = Frmt.numGrp;
    end    
    if nargin < 3 || isempty(numSep)
        numSep = Frmt.numSep;
    end
    
    numSep = char(numSep);
    txt = char(string(num));
    
    if length(txt) <= numGrp
        frmtted = txt;
        return
    end
    
    offset = numGrp + 1;
    rev = fliplr(txt);
    
    rev = [rev(1 : numGrp), numSep, rev(offset : end)];
    for iind = 1:length(rev)
        if rev(iind) == numSep && length(rev) >= iind + offset
            rev = [rev(1 : iind + numGrp), numSep, rev(iind + offset : end)];
        end
    end
    
    frmtted = string(fliplr(rev));
end