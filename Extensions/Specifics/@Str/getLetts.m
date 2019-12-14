function [letts, cells] = getLetts(str)
    if ~ismissing(str)
        chr = cellstr(string(str));
        cells = cellfun(@cellper, chr, 'uni', false);
        letts = cells_append(cells);
    else
        letts = "";
        cells = {};
    end
end

function letts = cellper(str)
    lett_inds = isletter(str);
    letts = repmat({''}, [1 length(lett_inds)]);
    
    ielem = 1;
    for iind = 1:length(str)
        if lett_inds(iind)
            letts{ielem} = [letts{ielem}, str(iind)];
        else
            ielem = ielem+1;
        end
    end
    
    letts = empty_strip(letts);
end

function letts = empty_strip(letts)
    if ~isempty(letts)
        empty_inds = ismember(letts, {char.empty});
        letts(empty_inds) = [];
    end
end

function letts = cells_append(cells)
    if isempty([cells{:}])
        letts = "";
    else
        letts = string.empty;
        for icell = 1:length(cells)
            letts(icell) = [cells{icell}{:}];
        end
    end
end