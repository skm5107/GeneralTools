function padded = pad(arr, sz, padVal, leftORright)
    padding = repmat(padVal, sz);
    if leftORright == "right"
        padded = [arr, padding];
    elseif leftORright == "left"
        padded = [padding, arr];
    end
end