function tfs = anyequaln(value, anyOfvalues)
    tfs = cellfun(@(jany) isequaln(value, jany), anyOfvalues);
end