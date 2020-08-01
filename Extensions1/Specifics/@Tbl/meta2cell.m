function meta = meta2cell(raw)
    meta = struct(raw.Properties);
    meta = cleanNames(meta);
    meta = struct2table(meta, 'AsArray', true);
    meta = table2cell(meta);
end

function cleaned = cleanNames(orig)
    olds = fields(orig);
    news = cellfun(@(iold) strcat("x", iold), olds);
    for ifld = 1:length(olds)
        cleaned.(news{ifld}) = orig.(olds{ifld});
    end
end