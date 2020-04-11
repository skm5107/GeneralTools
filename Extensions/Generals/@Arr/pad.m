function padded = pad(orig, reqSz, padVal)
    assert(ndims(orig) <= 3 && length(reqSz) <= 3, "Arr:size", "Function does not support ndim > 3")
    padded = repmat(padVal, reqSz);
    padded(1:size(orig,1), 1:size(orig,2), 1:size(orig,3)) = orig;
end