function tbl = cells2nested(cells)
    maxrows = 0;
    for icell = 1:length(cells)
        maxrows = max(maxrows, height(cells{icell}));
    end
    for icell = 1:length(cells)
        cells{icell} = Tbl.buffer(cells{icell}, maxrows - height(cells{icell}));
    end

    tbl = table();
    for icol = 1:size(cells,2)
        tbl{:,icol} = Arr.uncell(cells{:,icol});
    end
end