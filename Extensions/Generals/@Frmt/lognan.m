function [val, isAllLog] = lognan(raw, ~)
    % returns a numeric 0, 1, or NaN
    str = lower(string(raw));
    val = nan(size(str));
    val(str == "true" | str == "1") = 1;
    val(str == "false" | str == "0") = 0;
    
    indsLog = val == 0 | val == 1;
    val(~indsLog) = NaN;
    isAllLog = all(indsLog);
end
