function uniqued = nanunique(orig, firstORlast)
    miss_inds = find(ismissing(orig));
    uniqued = orig;
    if nargin < 2 || firstORlast == "first"
        uniqued(miss_inds(2:end)) = [];
    elseif firstORlast == "last"
        uniqued(miss_inds(2:end)) = [];
    else
        error("Arg:Unknown", 'nanunique(~, arg2) must be "first" or "last" (defaults to keeping first NaN)');
    end
end