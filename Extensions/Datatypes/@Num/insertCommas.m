function newstr = insertCommas(number, precision_decimals)
    if nargin < 2
        precision_decimals = 0;
    end
    
    [ints, decimals] = Num.getDigits(number, precision_decimals);
    str = num2str(ints);
    str = erase(str, " ");
    
    flipstr = fliplr(str);
    flipparsed = textscan(flipstr,'%3s');
    flipjoined = join(string(flipparsed{1}), ",");
    
    newstr = fliplr(char(flipjoined));
    newstr = string(newstr);
    if precision_decimals > 0
        newstr = newstr + "." + erase(join(string(decimals),"")," ");
    end
end