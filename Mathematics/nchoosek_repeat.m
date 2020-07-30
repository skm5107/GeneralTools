function [selects, avail] = nchoosek_repeat(availORinit, isInit)
    if isInit
        avail = cellfun(@initSingle, num2cell(availORinit), 'uni', 0);
    else
        avail = availORinit;
    end
    
    [selects, avail] = cellfun(@chooseSingle, avail, 'uni', 0);
end

function avail = initSingle(topVal)
    avail = 1:topVal;
end

function [jselects, javail] = chooseSingle(javail)
    [jselects, inds] = Rand.select(javail, 1);
    javail(inds) = [];
end