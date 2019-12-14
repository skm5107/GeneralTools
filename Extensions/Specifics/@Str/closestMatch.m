function [ind, match_frac] = closestMatch(strVect, str)
    match_frac = nan(size(strVect));
    tot_char = length(char(str));
    for istr = 1:length(strVect)
        remainder = erase(str, strVect(istr));
        remain_char = length(char(remainder));
        match_frac(istr) = (tot_char - remain_char) / tot_char;
    end
    match_frac(match_frac > 1) = NaN;
    [~, ind] = nanmax(match_frac);
end