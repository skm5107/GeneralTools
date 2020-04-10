function trans = invertMeta(raw)
    hndls = cellfun(@Frmt.findFcn, raw.formSpec, 'uni', 0);
    vals = cellfun(@convert, hndls, raw.value, 'uni', 0)';
    out = cell2table(vals);
    out.Properties.VariableNames = raw.varNames;
    out.Properties.VariableUnits = raw.varUnits;
    out.Properties.VariableDescriptions = raw.varDescs;
    out.Properties.Description = raw.Properties.Description;
    trans = NestTable(out).run;
end
function val = convert(hndl, raw)
    raw = string(raw);
    val = hndl(raw);
end