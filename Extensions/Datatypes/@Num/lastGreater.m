function last = lastGreater(array, val)
    vect = max(array, [], Num.getDim(array, "min"));
    last = find(vect >= val, 1, 'last');
end