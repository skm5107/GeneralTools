function chr = getDelim()
    path = fullfile("A", "B");
    if contains(path, "\")
        chr = "\";
    elseif contains(path, "/")
        chr = "/";
    else
        error("Folder:parse", ...
            "Operating system uses unknown folder delimiter");
    end
end