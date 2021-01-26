function readSpec = countMaxDelimiters(pathCsv)
    elem_qty = 0;
    jline = NaN;
    fid = fopen(pathCsv);
    %while  jline ~= -1
        jline = char(fgetl(fid));
        jqty = count(jline, FormattedCsv().delimiter);
        elem_qty = max(elem_qty, jqty);
    %end
    readSpec = join(repmat("%q", [1 elem_qty+2]), "");
    fclose(fid);
end