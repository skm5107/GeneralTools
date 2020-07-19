function foreground = centerPad(background, foreground, dims)
    fgnd = getSizes(foreground);
    bkg = getSizes(background);
    
    
    
    if contains("1", string(dims))
        rPad = makePad(bkg.hgt, fgnd.hgt, {fgnd.len, 3});
        foreground = [rowPadA; foreground; rowPadB];
        fgnd = getSizes(foreground);
    end
    
    if contains("2", string(dims))
        [colPadA, colPadB] = makeColPad(bkg.len, fgnd.len, fgnd.hgt);
        foreground = [colPadA, foreground, colPadB];
    end
end

function sz = getSizes(array)
    raw = size(array);
    [sz.hgt, sz.len, sz.color] = Arr.deal(raw);
end

function pad = makeRowPad(big, small, qty, otherDims)
    dimDiff = big-small;
    indEvens = 1:2:qty;
    indOdds = 2:2:qty;
    pad = cells(1, qty);
    padLen = dimDiff/qty;
    checker = mod(dimDiff, qty);
    
    switch checker
        case 0
            pad{:} = nan(padLen, oppSmall, 3);
        case 1
            pad{indOdds} = nan(ceil(padLen), otherDims{:});
            pad{indEvens} = nan(floor(padLen), otherDims{:});
        case 2
            pad{indOdds} = nan(floor(padLen), otherDims{:});
            pad{indEvens} = nan(ceil(padLen), otherDims{:});
    end
    
    if find(otherDims == inf) == 1
        pad = pad';
    end
end


    padA = zeros(hgt, dimDiffA, 3);
    padB = zeros(hgt, dimDiffB, 3);
end