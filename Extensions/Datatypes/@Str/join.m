function joined = join(strs, joiner, delNaN)
    strs = string(strs);
    
    if nargin < 3 || ~delNaN
        strs(ismissing(strs)) = "";
    else
        strs(ismissing(strs)) = [];
    end
    
    if nargin < 2
        joined = join(strs);
    else
        joined = join(strs, joiner);
    end
end