function out = eraseAny(orig, dels)
    out = string(size(orig));
    for istr = 1:length(orig)
        strC = char(orig(istr));
        for idel = 1:length(dels)
            delC = char(dels(idel));
            strC(strC == delC) = [];
        end
        out(istr) = string(strC);
    end
end