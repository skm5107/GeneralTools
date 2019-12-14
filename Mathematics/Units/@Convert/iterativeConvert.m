function val_out = iterativeConvert(val_in, unit_in, unit_out)
    convs = table(unit_in, val_in, 'VariableNames', {'unit_out', 'val_out'});
    val_out = [];
    counter = 0;
    while isempty(val_out) && counter < Convert.iterative_tries
        for irow = 1:height(convs)
            avail_rows = convs.unit_out(irow) == Convert.key.unitA;
            new = convertAllRows(convs.val_out(irow), avail_rows);
            convs = [convs; new]; %#ok<AGROW>
        end
        [~, ~, val_out] = Key.lookup(convs, unit_out, "unit_out", "val_out");
        counter = counter + 1;
    end
end

function convs = convertAllRows(val_in, avail_rows)
    convs = table();
    convs.unit_out = Convert.key.unitB(avail_rows);
    convs.val_out = val_in * Convert.key.AtoB_mult(avail_rows);
end