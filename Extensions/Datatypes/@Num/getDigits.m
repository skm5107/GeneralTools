function [ints, decimals] = getDigits(number, precision_decimals)
    posneg = sign(number);
    fspec = "%." + precision_decimals + "f";
    tot_qty = numel(num2str(number, fspec)) - 1;
    
    int = fix(abs(number));
    ints = dec2base(int, 10) - '0';
    ints = ints * posneg;
    
    remainder = number - int;
    decimal_qty = tot_qty - length(ints);
    remainder_int = round(remainder * 10^decimal_qty);
    nonzeros = dec2base(remainder_int, 10) - '0';
    zeros_qty = decimal_qty - length(nonzeros);
    decimals = Arr.pad(nonzeros, [1, zeros_qty], 0);
end