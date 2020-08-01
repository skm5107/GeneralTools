function meta = cell2meta(raw)
    props = loadPropNames(raw);
    meta = makeBlank(props, raw);
    for iprop = 1:length(props)
        meta.Properties.(props{iprop}) = raw{iprop};
    end
end

function props = loadPropNames(raw)
    meta = table();
    props = fields(struct(meta.Properties));
    assert(length(props) == length(raw), "Tbl:meta", "input contains unknown properties")
end

function meta = makeBlank(props, raw)
    sz = [length(raw{props == "RowNames"}), length(raw{props == "VariableNames"})];
    meta = cell2table(cell(sz)); 
end