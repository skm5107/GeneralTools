function difference = nansubtract(minuend, subtrahend)
    difference = minuend - subtrahend;
    indsNaN = all(isnan([minuend, subtrahend]), 2);
    difference(indsNaN, :) = 0;
end