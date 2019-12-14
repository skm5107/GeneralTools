function out = eraseAny(orig, dels)
    out = orig;
    for idel = 1:length(dels)
        out = erase(out, dels(idel));
    end
end