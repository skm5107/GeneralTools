function [val, arg2] = logcat(raw, ~)
    log = Frmt.log(raw);
    val = Frmt.catTF(log);
    arg2 = missing;
end
