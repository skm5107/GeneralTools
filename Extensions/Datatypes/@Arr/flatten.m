function [flat, origShape] = flatten(arr, horzORvert)
    origShape = size(arr);
    if horzORvert == "horz"
        flat = reshape(arr, 1, []);
    elseif horzORvert == "vert"
        flat = reshape(arr, [], 1);
    else
        error("Array:Flat", 'Arg2 in Arr.flatten(arr, horzORvert) must be "horz" or "vert"')
    end
end