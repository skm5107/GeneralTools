function tfs = contains(arr, includes)
    arr_tf = [];
    for icld = 1:length(includes)
        arr_tf(:, icld) = contains(arr, includes(icld));
    end
    tfs = all(arr_tf,2);
end